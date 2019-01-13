from fabric import *
from fabric.tasks import *

env.roledefs = {
    'training': ['10.0.0.1'],
    'web': ['10.0.1.1', '10.0.1.2'],
    'media': ['10.0.2.1'],
    'celery': ['10.0.3.1', '10.0.3.2'],
}

CONSUL_VERSION = '1.4.0'

def install_consul(conn):
    conn.run(f'curl https://releases.hashicorp.com/consul/{CONSUL_VERSION}/consul_{CONSUL_VERSION}_linux_amd64.zip -o /tmp/consul.zip')

conn = Connection('root@51.158.70.93')
install_consul(conn)

def deploy():
    execute('update_media')
    execute('update_and_restart')
    execute('update_celery')
