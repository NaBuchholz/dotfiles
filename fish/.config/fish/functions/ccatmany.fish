function ccatmany
    set -l tmp (mktemp)
    
    for f in $argv
        printf '\n===== %s =====\n\n' $f >> $tmp
        cat $f >> $tmp
        printf '\n' >> $tmp
    end
    
    printf '\e]52;c;%s\a' (base64 -w0 $tmp)
    rm $tmp
    
    echo "Arquivos copiados para o clipboard"
end
