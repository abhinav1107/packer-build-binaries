# packer-build-binaries

## Context
As of this writing, my current work place builds [Sensu Go](https://github.com/sensu/sensu-go), [Ansible](https://github.com/ansible/ansible) and [ffmmpeg](https://github.com/FFmpeg/FFmpeg) binaries. We use both Architecture types of x86_64 and arm64 and both Amazon Linux 2 and CentOS 7. Usually the packages built for Amazon Linux works with CentOS and vice versa, as long as we use the same arch type for binaries. But, we have noticed that sometimes this is not the case. So, at some point we decided that we will build binaries for all OS types and all arch types.

All 3 of these falls under something which I usually take care. And after initial 2-3 attempts, I got tired of manually building binaries. This is what I would usually do:
- launch 4 instances, 2 of each Arch type and both OS types for each Arch type.
- clone their respective git repo.
- perform compilation operation for each application.
- upload those buit binaries to S3 bucket.
- terminate instances.

I decided to do something about it. Wrote one ansible role which can do the whole thing. This repo is stripped down version of that work. Obviously, I can't copy the role in it's entirety.

## Info
I wrote this today, on the fly, taking cues from what we have in our work repo. So, there might be some mistakes here and there. My idea was to have it documented outside of work repo, so that I can come back and refer to this in case I needed to. The work one works well.

Running the playbook would be similar to this:
```
ansible-playbook -i inventory/packer-build/hosts build-binaries-with-packer.yml -e 'component=<sensu-go or ansible>'
```

Update ansible variables mentioned in role accourdingly.

Suppose we run this for ansible, once this playbook is done, we will see these files:
```
ansible-2.11.1-4.0.0-Amazon-NA-aarch64.tar.gz
ansible-2.11.1-4.0.0-Amazon-NA-x86_64.tar.gz
ansible-2.11.1-4.0.0-CentOS-7-aarch64.tar.gz
ansible-2.11.1-4.0.0-CentOS-7-x86_64.tar.gz
ansible-2.11.5-4.6.0-Amazon-NA-aarch64.tar.gz
ansible-2.11.5-4.6.0-Amazon-NA-x86_64.tar.gz
ansible-2.11.5-4.6.0-CentOS-7-aarch64.tar.gz
ansible-2.11.5-4.6.0-CentOS-7-x86_64.tar.gz
```

That's it for now I guess.
