services:
  mc:
    image: itzg/minecraft-server
    environment:
      EULA: "true"
      TYPE: VANILLA
      VERSION: 1.20.1
    ports:
      - "25565:25565"
    volumes:
      - ./data:/data
