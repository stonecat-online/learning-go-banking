postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:alpine3.17

createdb: 
	docker exec -it postgres12 createdb --username=root --owner=root simplebank

dropdb: 
	docker exec -it postgres12 dropdb --username=root --owner=root simplebank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simplebank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simplebank?sslmode=disable" -verbose down

migratereset:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simplebank?sslmode=disable" force 1

sqlc: 
	sqlc generate

test: 
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown migratereset sqlc

