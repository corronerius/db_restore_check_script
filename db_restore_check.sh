#!/bin/bash
username="postgres"
email=mail@!!!.com
tmp_file=/tmp/t.txt
export PGPASSWORD='!!!'
pattern=" id | name | description | mailfrom | prefix | smtp_port | protocol | server_type | servername | jndilocation | mailusername | mailpassword | istlsrequire$
----+------+-------------+----------+--------+-----------+----------+-------------+------------+--------------+--------------+--------------+---------------+------$
(0 rows)!"
echo "From: <info@domein.com>" > $tmp_file
echo "To: <$email>" >> $tmp_file
echo "Subject: DB restore checking results" >> $tmp_file
echo "" >> $tmp_file
echo "CREATE DATABASE restore_check WITH OWNER = postgres TABLESPACE = pg_default CONNECTION LIMIT = -1" | psql -U $username -h localhost -p 5432 &> /dev/null
gunzip -c !!!jiradb_bup.pgsql.gz | psql -d restore_check -U $username -h localhost -p 5432 &> /dev/null
myvar=$(psql -d restore_check -U $username -h localhost -p 5432 -c "SELECT * FROM mailserver;")
echo "DROP DATABASE restore_check;" | psql -U postgres -h localhost -p 5432 &> /dev/null
if [ "$myvar" = "$pattern" ];
        then (echo "OK">>$tmp_file) && sendmail -f "info@!!!.com" $email < $tmp_file;
        else (echo "$myvar" >>$tmp_file) && sendmail -f "info@!!!.com" $email < $tmp_file;
fi

