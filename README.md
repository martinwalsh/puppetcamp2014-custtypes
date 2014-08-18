puppetcamp2014-custtypes
========================

A project for the 2014 PupppetCamp Custom Providers Talk

An outline for the talk:

## Introduction

Introducing myself, who I am, etc.

## Customizing Your Puppet Environment

To this point, I'm going to assume that we've learned a few things about puppet, perhaps
migrating our code from

  1. Simple manifest files.
  2. Downloading modules from the Puppet Forge.
  3. Writing your own modules!
  4. Defined a few custom types with Puppet DSL.
  
## Where Puppet Excels

Encapsulation
 `file{"/etc/config.conf":
        ensure => "directory",
        owner  => 'devuser',
        content => "key value"
   }`  
   
Dependencies: Puppet uses a dependency graph heavily - some resources depend on 
other resources.  This dependency must be explicity declared.
   
Where puppet does not do so well:  executing a defined instruction set in a particular
order.
  
## Running into Ugliness

Puppet DSL

`   case $environment {
    'vagrant': {
      # Copy SSH keys into place
      file{"/home/devuser/.ssh":
        ensure => "directory",
        owner  => 'dice',
      }->
      exec{"cp /opt/ssh-keys/* /home/devuser/.ssh/":
        path => "/bin:/usr/bin",
        user => 'devuser',
        creates => '/home/devuser/.ssh/id_rsa.pub',
      }->
      exec{"chown dice:dice /home/devuser/.ssh/*":
        path => "/bin:/usr/bin",
        user => "devuser",
      }->
      exec{"chmod -R 0400 /home/devuser/.ssh/*":
        path => "/bin:/usr/bin",
      }->
      file{"/home/devuser/.ssh/config":
        ensure => present,
        owner => 'devuser',
        group => 'devuser',
        content => "StrictHostKeyChecking no",
      }
     }
`
This is an example of running many sequential commands within the puppet DSL.
(There are many other ways of doing this as well - though each requires 'abusing' the 
puppet dependency model.)

## Types and Providers

What you might want in many of these cases is to wrap up functionality in a "TYPE".  
We have seen a few examples of using puppet types with the use of DSL defined types

( https://docs.puppetlabs.com/learning/definedtypes.html )

## Defining A Custom Type

## Defining A Custom Provider
