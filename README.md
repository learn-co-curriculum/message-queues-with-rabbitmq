---
tags: bunny, rabbitmq, amqp, messaging, enterprise, scaling
language: ruby
---

# Messaging

## Overview

RabbitMQ is a message queueing system, meaning that it's responsibility is to receive messages containing a data payload and then distribute that message to all interested parties based on certain criteria.

As the world's technology becomes more distributed, the need to
of share information between various entities becomes increasingly
important. Using message-oriented middleware like RabbitMQ, an
implementation of AMQP (Advanced Message Queuing Protocol), can help us to
solve this category of problem.

### Advantages

* A single interface between applications built with different
technologies
* Asynchronicity
* Robust communication that is resistant to failure
* Easy integration of additional applications depending on existing
messages.

### Disadavantages
The main disadvantage is the requirement of an additional component in
the system, the message broker.
"As with any system, adding another component can lead to reductions in performance and reliability, and can also make the system as a whole more difficult and expensive to maintain." - [wikipedia](http://en.wikipedia.org/wiki/Message-oriented_middleware#Disadvantages)

## Instructions
For this exercise, you'll be using the [Bunny](https://github.com/ruby-amqp/bunny) library, a wrapper around the Ruby [amqp gem](https://github.com/ruby-amqp/amqp).

Using the tests for guidance, connect the provided CMS application with
the sales application. Whenever a product is created, updated, or
destroyed in the CMS, it should be reflected in the Sales application.

This interaction should take place using a direct exchange to place
messages on two queues named "product_upsert" and "product_destroy".

In the product-cms-app, write your implementatin in `app/publishers/product_publisher.rb`.

In the product-sales-app, write your implementation in `app/workers/product_consumer.rb`.

First, you'll need to figure out what all that means. See these guides
on the Bunny docs:

* [Connecting](http://rubybunny.info/articles/connecting.html)
* [Queues](http://rubybunny.info/articles/queues.html)
* [Direct Exchanges](http://rubybunny.info/articles/exchanges.html#direct_exchanges)

The tests can be run with the `rspec` command.

A web interface to the rabbitmq server can be found at
http://localhost:15672/ with credentials guest/guest.

Disclaimer:

This is not a guide for implementing a highly robust messaging solution,
it is simply enough to begin understanding the concepts involved with using
RabbitMQ.

### Configuration

#### Mac

To get your development environment up:

1. `brew install rabbitmq`

2. Use `bin/restart_apps` to start up the CMS and Sales servers and `bin/start_rabbitmq` for the RabbitMQ server.

There is also a `bin/reset_rabbitmq` that cleans out RabbitMQ (removes all
queues, exchanges, etc.).

## History
Messaging queues got their start in 1983 when
[Vivek Ranadive](http://en.wikipedia.org/wiki/Vivek_Ranadiv%C3%A9) created the
idea of a software "bus", much like the hardware buses in computers that
move information from component to component. The technology found it's initial
success with financial trading companies like Goldman Sachs.

However, queuing solutions were out of reach for many developers due to
expensive proprietary vendor solutions. It wasn't until J.P. Morgan developed
the open standard AMQP (Advanced Message Queueing Protocol) in 2003 that
queuing solutions became highly available to all developers. RabbitMQ
was one of the first implementations of AMQP.

## Resources
* [Why Rubyists Should Care About Messaging](http://www.rubyinside.com/why-rubyists-should-care-about-messaging-a-high-level-intro-5017.html)
* [Bunny - Getting Started](http://rubybunny.info/articles/getting_started.html)
* [Using channels with RabbitMQ](http://derickbailey.com/2014/03/26/2-lessons-learned-and-3-resources-for-for-learning-rabbitmq-on-nodejs/)
