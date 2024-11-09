target_date="$1"
target_day="$(date -d "$(date +%g)-$1" +%j)"
current_day="$(date +%j)"
if [[ "$current_day" -gt "$target_day" ]]; then
    target_day=$target_day+365
fi

difference=$((target_day - current_day))
if (( difference == 0 )); then
  echo -n "$2"
else
  echo -n "$difference Days"
fi
