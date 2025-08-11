# A simple make file for controlling ansible to deploy my configuration to other machines.

# Display all the options to run
help:
	@echo "Run options:"
	@echo "install   - Installs the uv environment for ansible"
	@echo "clean     - Removes the ansible environment."

# Install the development environment
install: uv

uv:
	curl -LsSf https://astral.sh/uv/install.sh | env UV_UNMANAGED_INSTALL="${PWD}/uv" sh


shell:
	@export UV_CACHE_DIR=${PWD}/uv/cache && \
	export UV_PYTHON_INSTALL_DIR=${PWD}/uv/python && \
	export UV_PYTHON_TOOL_DIR=${PWD}/uv/tools && \
	export PATH="${PWD}/uv:${PATH}" && \
	export KRB5_CONFIG="${PWD}/ticket/krb5.conf" && \
    export KRB5CCNAME="${PWD}/ticket/ticket.ccache" && \
	./uv/uv run sh -c '. ${PWD}/.venv/bin/activate; sh'

health:
	@export UV_CACHE_DIR=${PWD}/uv/cache && \
	export UV_PYTHON_INSTALL_DIR=${PWD}/uv/python && \
	export UV_PYTHON_TOOL_DIR=${PWD}/uv/tools && \
	export PATH="${PWD}/uv:${PATH}" && \
	export KRB5_CONFIG="${PWD}/ticket/krb5.conf" && \
    export KRB5CCNAME="${PWD}/ticket/ticket.ccache" && \
	./uv/uv run ansible-playbook -i inventory.ini playbooks/healthtest.yaml

install-ohmyzsh:
	@export UV_CACHE_DIR=${PWD}/uv/cache && \
	export UV_PYTHON_INSTALL_DIR=${PWD}/uv/python && \
	export UV_PYTHON_TOOL_DIR=${PWD}/uv/tools && \
	export PATH="${PWD}/uv:${PATH}" && \
	export KRB5_CONFIG="${PWD}/ticket/krb5.conf" && \
    export KRB5CCNAME="${PWD}/ticket/ticket.ccache" && \
	./uv/uv run ansible-playbook -i inventory.ini playbooks/ohmyzsh.yaml

# Clean up the development environment
clean:
	rm -rf uv