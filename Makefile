all:
	make slim
	make latest
	make pandoc

slim:
	docker build --no-cache -t foliant/foliant:slim -f Dockerfile-slim .

latest:
	docker build --no-cache -t foliant/foliant .

pandoc:
	docker build --no-cache -t foliant/foliant:pandoc -f Dockerfile-pandoc .
