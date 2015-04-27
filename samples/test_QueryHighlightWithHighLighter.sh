# [2013-11-22T15:32:22.068213]
curl -XHEAD 'http://127.0.0.1:9200/test-index?pretty=true'
# response status: 404
# response body: 
# [2013-11-22T15:32:22.068965]
curl -XPUT 'http://127.0.0.1:9200/test-index?pretty=true'
# response status: 200
# response body: {"ok":true,"acknowledged":true}
# [2013-11-22T15:32:22.097793]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type/_mapping?pretty=true' -d '{"test-type": {"properties": {"pos": {"type": "integer", "store": "yes"}, "uuid": {"index": "not_analyzed", "boost": 1.0, "store": "yes", "type": "string"}, "parsedtext": {"index": "analyzed", "term_vector": "with_positions_offsets", "boost": 1.0, "store": "yes", "type": "string"}, "name": {"index": "analyzed", "term_vector": "with_positions_offsets", "boost": 1.0, "store": "yes", "type": "string"}, "title": {"index": "analyzed", "term_vector": "with_positions_offsets", "boost": 1.0, "store": "yes", "type": "string"}}}}'
# response status: 200
# response body: {"ok":true,"acknowledged":true}
# [2013-11-22T15:32:22.106133]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type/1?pretty=true' -d '{"position": 1, "parsedtext": "Joe Testere nice guy", "name": "Joe Tester", "uuid": "11111"}'
# response status: 201
# response body: {"ok":true,"_index":"test-index","_type":"test-type","_id":"1","_version":1}
# [2013-11-22T15:32:22.108840]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type/2?pretty=true' -d '{"position": 2, "parsedtext": "Joe Testere nice guy", "name": "Bill Baloney", "uuid": "22222"}'
# response status: 201
# response body: {"ok":true,"_index":"test-index","_type":"test-type","_id":"2","_version":1}
# [2013-11-22T15:32:22.111194]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type/2?pretty=true' -d '{"position": 2, "parsedtext": "Joe Testere nice guy", "uuid": "22222"}'
# response status: 200
# response body: {"ok":true,"_index":"test-index","_type":"test-type","_id":"2","_version":2}
# [2013-11-22T15:32:22.112539]
curl -XPOST 'http://127.0.0.1:9200/test-index/_refresh?pretty=true'
# response status: 200
# response body: {"ok":true,"_shards":{"total":10,"successful":5,"failed":0}}
# [2013-11-22T15:32:22.120785]
curl -XGET 'http://127.0.0.1:9200/_cluster/health?wait_for_status=green&timeout=0s&pretty=true'
# response status: 200
# response body: {"cluster_name":"elasticsearch","status":"yellow","timed_out":true,"number_of_nodes":1,"number_of_data_nodes":1,"active_primary_shards":12,"active_shards":12,"relocating_shards":0,"initializing_shards":0,"unassigned_shards":11}
# [2013-11-22T15:32:22.322413]
curl -XGET 'http://127.0.0.1:9200/test-index/_search?from=0&pretty=true&size=10' -d '{"query": {"query_string": {"query": "joe"}}, "highlight": {"pre_tags": ["<b>"], "fields": {"parsedtext": {"order": "score"}, "name": {"order": "score"}}, "post_tags": ["</b>"]}}'
# response status: 200
# response body: {"took":2,"timed_out":false,"_shards":{"total":5,"successful":5,"failed":0},"hits":{"total":2,"max_score":0.22295055,"hits":[{"_index":"test-index","_type":"test-type","_id":"2","_score":0.22295055, "_source" : {"position": 2, "parsedtext": "Joe Testere nice guy", "uuid": "22222"},"highlight":{"parsedtext":["<b>Joe</b> Testere nice guy"]}},{"_index":"test-index","_type":"test-type","_id":"1","_score":0.13561106, "_source" : {"position": 1, "parsedtext": "Joe Testere nice guy", "name": "Joe Tester", "uuid": "11111"},"highlight":{"name":["<b>Joe</b> Tester"],"parsedtext":["<b>Joe</b> Testere nice guy"]}}]}}
# [2013-11-22T15:32:22.325989]
curl -XGET 'http://127.0.0.1:9200/test-index/_search?from=0&pretty=true&size=1' -d '{"query": {"query_string": {"query": "joe"}}, "highlight": {"pre_tags": ["<b>"], "fields": {"parsedtext": {"order": "score"}, "name": {"order": "score"}}, "post_tags": ["</b>"]}}'
# response status: 200
# response body: {"took":1,"timed_out":false,"_shards":{"total":5,"successful":5,"failed":0},"hits":{"total":2,"max_score":0.22295055,"hits":[{"_index":"test-index","_type":"test-type","_id":"2","_score":0.22295055, "_source" : {"position": 2, "parsedtext": "Joe Testere nice guy", "uuid": "22222"},"highlight":{"parsedtext":["<b>Joe</b> Testere nice guy"]}}]}}
# [2013-11-22T15:32:22.328757]
curl -XHEAD 'http://127.0.0.1:9200/test-index?pretty=true'
# response status: 200
# response body: 
# [2013-11-22T15:32:22.329471]
curl -XDELETE 'http://127.0.0.1:9200/test-index?pretty=true'
# response status: 200
# response body: {"ok":true,"acknowledged":true}
