# Jupyter Server configuration for Language Servers

c.LanguageServerManager.language_servers = {
    "basedpyright": {
        "argv": [
            "/Users/djo/.local/share/uv/tools/jupyterlab/bin/basedpyright-langserver",
            "--stdio"
        ],
        "languages": ["python"],
        "version": 2,
        "mime_types": ["text/python", "text/x-ipython"],
        "display_name": "basedpyright",
    }
}
