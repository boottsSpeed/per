PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c "

if [[ -z $1 ]]; then 
  echo "Please provide an element as an argument."
  exit 0
fi


FOUND=$($PSQL "select * from elements e left join properties p on p.atomic_number = e.atomic_number left join types t on t.type_id = p.type_id where (e.atomic_number::text = '$1' or e.symbol = '$1'or e.name = '$1')")
if [[ -z $FOUND ]]; then 
  echo "I could not find that element in the database."
else
  IFS='|' read anum symbol name anum2 amass mpc bpc td td1 typee <<< $FOUND
  echo "The element with atomic number $anum is $name ($symbol). It's a $typee, with a mass of $amass amu. $name has a melting point of $mpc celsius and a boiling point of $bpc celsius."
fi

