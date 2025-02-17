This is a [docker-compose](https://docs.docker.com/compose/) app that will run a bare ComfyUI installation with only the ComfyUI-Manager loaded.

## Getting Started

Clone this repo, then:

```bash
docker compose up
```

This will spin up ComfyUI to run at [localhost:8188](http://localhost:8188) while mapping local directories to specific ComfyUI functions:

| Local Path         | Function                                      |
|--------------------|-----------------------------------------------|
| `./user`           | ComfyUI's user directory where all user information, including settings, is stored  |
| `./models`         | ComfyUI's models directory       |
