if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo  $(git rev-parse --abbrev-ref HEAD);
else
    echo "";
fi

