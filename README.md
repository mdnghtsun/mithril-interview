# mithril-interview
interview homework - senior sre engineer 

## Description
This playbook deploys a logrotate configuration file for the systemd service custom-monitor.service. 
It does not start logrotate nor rotate the logs for custom-monitor.service itself by design. 


## Design
0. Check logrotate status (tagged never to run only when specified)
1. Check directory exists and permissions
2. Deploy logrotate configuration file 

### Additional Notes
I thought about including a task to ensure logrotate is started idempotently but felt it was outside the scope of the spec/requirements:
```
  # Check and start logrotate if not started
  - name: Ensure logrotate started
    ansible.builtin.systemd:
      name: logrotate
      state: started
```

To force a rotation for the custom-monitor service, the following command is documented:
```
sudo logrotate -f /etc/logrotate.d/custom-monitor
```

And could be invoked in a task like so: 
```
  tasks:
    - name: Rotate custom-monitor logs with logrotate
      ansible.builtin.command: logrotate -f /etc/logrotate.d/custom-monitor
      become: yes
```

Another thought was to paramterize the service name (i.e. custom-monitor) via jinja2 templating but I felt that was outside the scope of the requirements. If we were to include that as a feature, we'd make a few changes: 
1. replace references of 'custom-monitor' with '{{ service_name }}' in playbook
2. ensure log rotation configuration file exists for each service (i.e. service-monitor, another-service-monitor, etc) defining the logrotate reqiurements for each service 
3. ensure playbook asks for variable service_name as an extra vars like: 
```
ansible-playbook -i inventory.yml logrotate.yml --extra-vars "service_name=custom-monitor"
```



## Installation
Clone from github

```bash
git clone https://github.com/mdnghtsun/mithril-interview.git
```

or

```bash
git clone git@github.com:mdnghtsun/mithril-interview.git
```
Note: repository is private 

## Requirements
Ensure ssh key is properly configured on local 

## Usage

```ansible
ansible-playbook -i inventory.yml logrotate.yml
```

verbose with optional tags
```ansible
ansible-playbook -i inventory.yml logrotate.yml --tags [never,verify,deploy] -v
```

## Authors
[Sunny Mundra ](https://github.com/mdnghtsun)

  # Check and start logrotate if not started
  - name: Ensure logrotate started
    ansible.builtin.systemd:
      name: logrotate
      state: started