## Ruby Script

##### Ruby version used 2.7.1

### Program to retrieve information for all given IDs from an api
- Limitation: The only API available for returning this data takes one item at a time. Additionally, the API is limited to five simultaneous requests. Any additional requests will be served with HTTP 429 (too many requests).


### Cmd To Run the Script

- `ruby get-items-data.rb id1 id2 id2 .... idn`
- eg:
  - `ruby get-items-data.rb 1 2 3 4 5` 
