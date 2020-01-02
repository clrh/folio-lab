# Folio database

```bash
# vagrant box context or default install
psql -U okapi -W -h 10.0.2.15
password: okapi25
# another way
sudo -u postgres -i
psql -U okapi postgresql://localhost:5432/okapi
```

## Postgres Tools

### General

```
List databases  `\l`
List tables     `\dt+`
Desc table      `\d+ TABLE`
List users      `\du`
Use database    `\c DATABASE`
List all relations  `\dt *.*.`
```

### Folio specific

```bash
# find hostname and informations in a default install
ps auxf|grep Dpostgres_database
```

```sql
\d+ modules;

select jsonb_pretty(modulejson) from modules;
select modulejson->>'id' from modules;

# équivalents (@> utilise un index donc plus performant)
select modulejson->>'id' from modules where modulejson @> '{"id":"folio_inventory-1.13.1000650"}';
SELECT modulejson->>'id' FROM modules WHERE modulejson->'id' = '"folio_inventory-1.13.1000650"';
SELECT modulejson->>'id' FROM modules WHERE modulejson->>'id' = 'folio_inventory-1.13.1000650';
```

```bash
postgresql://localhost:5432/okapi -c "select jsonb_pretty(modulejson) from modules;" > modules.out
psql -U okapi postgresql://localhost:5432/okapi -c "select modulejson->>'id' from modules;"
```

### References

#### Folio

* https://dev.folio.org/faqs/explain-database-schema/

#### General

* https://riptutorial.com/fr/postgresql/example/3337/interrogation-de-documents-json-complexes
* https://www.enterprisedb.com/fr/blog/crud-json-postgresql
* https://riptutorial.com/fr/postgresql/example/5195/utilisation-des-operateurs-jsonb
* https://www.postgresql.org/docs/9.3/functions-json.html
* http://www.postgresqltutorial.com/postgresql-json/

