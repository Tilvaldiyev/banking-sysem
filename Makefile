postgres:
	docker run --name postgres-db --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=fcrbgfhjkm -d postgres

createdb:
	docker exec -it postgres-db createdb --username=root banking_system

dropdb:
	docker exec -it postgres-db dropdb banking_system

migrateup:
	migrate -path db/migration -database "postgresql://root:fcrbgfhjkm@localhost:5432/banking_system?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:fcrbgfhjkm@localhost:5432/banking_system?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:fcrbgfhjkm@localhost:5432/banking_system?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:fcrbgfhjkm@localhost:5432/banking_system?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -destination=db/mock/store.go --build_flags=--mod=mod -package=mockdb github.com/Tilvaldiyev/banking-system/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migrateup1 migratedown migratedown1 sqlc test server mock