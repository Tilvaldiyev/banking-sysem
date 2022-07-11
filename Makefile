postgres:
	docker run --name postgres-db -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=fcrbgfhjkm -d postgres

createdb:
	docker exec -it postgres-db createdb --username=root banking_system

dropdb:
	docker exec -it postgres-db dropdb banking_system

migrateup:
	migrate -path db/migration -database "postgresql://root:fcrbgfhjkm@localhost:5432/banking_system?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:fcrbgfhjkm@localhost:5432/banking_system?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server