postgres:
	docker run --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres:alpine3.17

createdb:
	docker exec -it some-postgres createdb --username=postgres --owner=postgres --encoding=UTF8 --locale=en_US.utf8 --template=template0 --lc-collate=en_US.utf8 --lc-ctype=en_US.utf8 simple_crypto_exchange

dropdb:
	docker exec -it some-postgres dropdb --username=postgres simple_crypto_exchange

migrateup:
	migrate -path db/migration -database "postgresql://postgres:mysecretpassword@localhost:5432/simple_crypto_exchange?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:mysecretpassword@localhost:5432/simple_crypto_exchange?sslmode=disable" -verbose down
	
.PHONY: postgres createdb dropdb migrateup migratedown
