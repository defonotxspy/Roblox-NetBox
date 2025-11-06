# Roblox Netbox

The Roblox Netbox project is the home of our production Netbox environment, this project also includes an integration and a development environment. 
In addition to the netbox project we are storing here
- Roblox Specific Reports
- A Django module called roblox which include various API and view we developed
- Some custom modifications

## List of custom modifications & fixes

- [eric] add QR code support


## Environements Available

This project includes 3 environments:
 - **production** Designed to run in Nomad (App and Front End)
 - **integration** Designed to run in Nomad (App, Front End and DB)
 - **development** Designed to run locally on a laptop (Django dev server with local replica of the database)

### Production

> Add info 

### Integration

> Add info 

### Development

> Add info 

## Secret management

For the production and the integration environment, the sensitive information are saved in Vault at:  
 - secret/teams/neteng/netbox/production
 - secret/teams/neteng/netbox/integration

## How to create a netbox database snapshot container

Connect to production Database server (`not-giving-the-prod-database-name`)
```
# make a copy of the latest backup file in /tmp
cp /var/netbox-db-backup/db_backup.gz /tmp/db_backup.gz

cd /tmp/
gunzip db_backup.gz
```

On your local device
```
# At the root of the project
scp not-giving-the-prod-database-name:/tmp/db_backup . 
make db-build
make db-push
rm db_backup
```

----------------------------------------------------

![NetBox](docs/netbox_logo.png "NetBox logo")

NetBox is an IP address management (IPAM) and data center infrastructure management (DCIM) tool. Initially conceived by the network engineering team at [DigitalOcean](https://www.digitalocean.com/), NetBox was developed specifically to address the needs of network and infrastructure engineers.

NetBox runs as a web application atop the [Django](https://www.djangoproject.com/) Python framework with a [PostgreSQL](http://www.postgresql.org/) database. For a complete list of requirements, see `requirements.txt`. The code is available [on GitHub](https://github.com/digitalocean/netbox).

The complete documentation for NetBox can be found at [Read the Docs](http://netbox.readthedocs.io/en/stable/).

Questions? Comments? Please subscribe to [the netbox-discuss mailing list](https://groups.google.com/forum/#!forum/netbox-discuss), or join us on IRC in **#netbox** on **irc.freenode.net**!

### Build Status

NetBox is built against both Python 2.7 and 3.5.  Python 3.5 is recommended.

|             | status |
|-------------|------------|
| **master** | [![Build Status](https://travis-ci.org/digitalocean/netbox.svg?branch=master)](https://travis-ci.org/digitalocean/netbox) |
| **develop** | [![Build Status](https://travis-ci.org/digitalocean/netbox.svg?branch=develop)](https://travis-ci.org/digitalocean/netbox) |

## Screenshots

![Screenshot of main page](docs/media/screenshot1.png "Main page")

![Screenshot of rack elevation](docs/media/screenshot2.png "Rack elevation")

![Screenshot of prefix hierarchy](docs/media/screenshot3.png "Prefix hierarchy")

# Installation

Please see [the documentation](http://netbox.readthedocs.io/en/stable/) for instructions on installing NetBox. To upgrade NetBox, please download the [latest release](https://github.com/digitalocean/netbox/releases) and run `upgrade.sh`.

## Alternative Installations

* [Docker container](https://github.com/digitalocean/netbox-docker)
* [Heroku deployment](https://heroku.com/deploy?template=https://github.com/BILDQUADRAT/netbox/tree/heroku) (via [@mraerino](https://github.com/BILDQUADRAT/netbox/tree/heroku))
* [Vagrant deployment](https://github.com/ryanmerolle/netbox-vagrant)
