#README

-------
NOTES
=====

Database
--------

Setup should be a three step dance.

1. Look at config/database.yml and create the configured database and user. This is an exercise left
   to the reader, but in a nutshell: install postgres, create the db, create the user with sufficient privileges so that it can drop/create the database.
2. rake db:reset
3. rake db:migrate

If you're comfortable enough with postgres and intend to poke in the database at a lower level, then also set
your schema search path:

    alter database quran_dev set search_path = "$user", quran, content, audio, i18n, public;


Elasticsearch
-------------

It's painful. But this will help a lot:

* Web portal: sudo plugin -install mobz/elasticsearch-head
    * Git: https://github.com/mobz/elasticsearch-head
    * `open http://localhost:9200/_plugin/head/`
* To view all indices
    * http://localhost:9200/_cat/indices?v
* Problems with indices or routing? (RoutingMissingException)
    * Delete the index
    * http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/indices-delete-index.html
* View mappings:
    * http://localhost:9200/bookstore/_mapping
