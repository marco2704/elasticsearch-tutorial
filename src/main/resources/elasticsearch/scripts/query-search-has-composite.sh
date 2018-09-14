#!/usr/bin/env bash

curl -i -H 'Content-Type: application/json' http://localhost:9200/books/books/_search?pretty -d '
{
   "size": 10,
   "_source": [ "title", "publisher" ],
   "query": {
       "bool" : {
          "must" : [
              {
                  "range" : {
                      "rating" : { "gte" : 4 }
                  }
              },
              {
                  "nested": {
                      "path": "categories",
                      "query" : {
                          "match": {
                              "categories.name" : "search"
                          }
                      }
                  }
              }
          ]
       }
    }
}'