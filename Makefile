postgres:
	docker run --name postgres-db -p 5432:5432  -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine
createdb:
	docker exec -it postgres-db createdb --username=root --owner=root d_bank

dropdb:
	docker exec -it postgres-db dropdb --username=root d_bank

migrateup:
	migrate -path db/migration/  -database postgresql://root:secret@localhost:5432/d_bank?sslmode=disable  -verbose up

migratedown:
	migrate -path db/migration/  -database postgresql://root:secret@localhost:5432/d_bank?sslmode=disable  -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test