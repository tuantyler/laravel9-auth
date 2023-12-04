build:
	docker-compose build

build-no-cache:
	docker-compose build --no-cache

up:
	docker-compose up -d

stop:
	docker-compose stop

down:
	docker-compose down --remove-orphans

logs:
	docker-compose logs -f

reset: down build up

exec:
	docker-compose exec app bash

optimize:
	docker-compose exec app php artisan optimize:clear

phpcs:
	docker-compose exec app ./vendor/bin/phpcs

phpcbf:
	docker-compose exec app ./vendor/bin/phpcbf

phpmd:
	docker-compose exec app ./vendor/bin/phpmd app html ./phpmd-ruleset.xml > ./public/reports/phpmd.html

phpstan:
	docker-compose exec app ./vendor/bin/phpstan analyse --memory-limit=2G

test:
	docker-compose exec app php artisan test --coverage-html public/reports/coverage
