.PHONY: all clean documentation

all: \
	clean

create-next-tag:
	@echo "=====================================================================================>"
	@echo "Create new tag ..."
	./scripts/create-tag.sh -i

zip:
	$(MAKE) -C io_scene_dae zip

fix-py-permissions:
	find . -type f -name '*.py' -exec chmod 755 {} +

clean:
	@echo "=====================================================================================>"
	@echo "Cleaning ..."
	find . -type d -name '__pycache__' -exec rm -r {} +
