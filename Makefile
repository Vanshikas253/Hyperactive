clean: clean-pyc clean-ipynb clean-catboost clean-build clean-test

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-ipynb:
	find . -name '*.ipynb_checkpoints' -exec rm -fr {} +

clean-catboost:
	find . -name 'catboost_info' -exec rm -fr {} +

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-test:
	cd tests/; \
		rm -f .coverage; \
		rm -fr htmlcov/

test:
	pytest tests/test_optimizers.py -p no:warnings
	pytest tests/test_arguments_api.py -p no:warnings
	pytest tests/test_packages.py -p no:warnings

push: test
	git push

release:
	python setup.py sdist upload
	python setup.py bdist_wheel upload

dist:
	python setup.py sdist
	python setup.py bdist_wheel
	ls -l dist

install:
	pip install .

develop:
	pip install -e .

reinstall:
	pip uninstall -y hyperactive
	rm -fr build dist hyperactive.egg-info
	python setup.py bdist_wheel
	pip install dist/*
