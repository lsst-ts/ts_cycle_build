#!/bin/ash

temp_sql="view_backup.sql"
echo "Starting database dump"
pg_dump -w -t ui_framework_view -a > ${temp_sql}
if [ $? -eq 0 ] ; then
  echo "Finished database dump"
else
  echo "Database dump failed"
  exit 254
fi

echo "Starting JSON conversion"
python3 create_initial_data_json.py ${CONVERT_SCRIPT_OPTS} ${temp_sql}
if [ $? -eq 0 ] ; then
  echo "Finished JSON conversion"
else
  echo "JSON conversion failed"
  exit 253
fi

aws_upload=$(python3 make_s3_info.py ${LOVE_SITE} "initial_data.json")

echo "Starting LFA upload"
aws ${aws_upload}
if [ $? -eq 0 ] ; then
  echo "Finished LFA upload"
else
  echo "LFA upload failed"
  exit 252
fi
