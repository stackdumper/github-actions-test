.PHONY:
build:
	docker build -f actions/build/Dockerfile -t github-actions-test .

.PHONY:
run:
	docker run -p 8080:8080 -t github-actions-test
