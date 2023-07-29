# docs/index.md

## the prompt 

<code>
Use Docker and Compose to build an infrastructure that complies with the items below.

- Every internet connection between Host and Containers must pass a proxy (traefik).
    a. There must be a logging service
- There must be some IDS (intrusion detection system) service, like Suricata.
- There must be a Postgresql database.
- There must be a stable Debian operating system with the following requirements:
    a. a secure network to communicate with other internal services. probably 
    b. any network to communicate with host (i think Docker already has one)
    c. the "machine" folder should just be copied to the main service.
    d. the "machine_shared" folder must be a volume shared with the service, reflecting changes between host and service.
    e. must have security tools like .
    f. must have pentest tools.
    g. must have a VNC server running
- There must be rules so that the maximum consumption of services is 512 MB


Below is the folder structure I thought of. Feel free to use another one or mine. Folder "denv" represents our principal service, that is a operational system (i.g., Debian, ubuntu, etc). Inside it are its folders respecting the linux file system structure.
```
project
├── denv
│   ├── Dockerfile
│   ├── machine
│   │   ├── home
│   │   └── root
│   └── machine_shared
├── docker-compose.yml
└── scripts
    ├── build.sh
    ├── entrypoint.sh
    ├── entrypoint_ssh.sh
    └── run.sh
```

</code>