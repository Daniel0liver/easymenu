package db

import (
	"database/sql"
	"fmt"
	"os"
	"time"

	_ "github.com/lib/pq"
)

type configs struct {
	Port     string
	Host     string
	Name     string
	User     string
	Password string
}

type DB struct {
	*sql.DB
}

const connTimeout = 5
const maxIdleConn = 5
const maxOpenConn = 10
const maxConnLifetime = 5 * time.Minute

func NewDB() (*DB, error) {
	c := &configs{
		Port:     os.Getenv("DB_PORT"),
		Host:     os.Getenv("DB_HOST"),
		Name:     os.Getenv("DB_NAME"),
		User:     os.Getenv("DB_USER"),
		Password: os.Getenv("DB_PASSWORD"),
	}

	src := fmt.Sprintf("port=%s host=%s dbname=%s user=%s password=%s connect_timeout=%d sslmode=disable timezone=UTC",
		c.Port,
		c.Host,
		c.Name,
		c.User,
		c.Password,
		connTimeout,
	)

	conn, err := sql.Open("postgres", src)
	if err != nil {
		return nil, err
	}

	conn.SetMaxOpenConns(maxOpenConn)
	conn.SetMaxIdleConns(maxIdleConn)
	conn.SetConnMaxLifetime(maxConnLifetime)

	err = conn.Ping()
	if err != nil {
		return nil, err
	}

	return &DB{conn}, nil
}
