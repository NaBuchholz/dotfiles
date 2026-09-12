# ============================================================
# Nyx — Fish
# Configuração compartilhada entre desktop e notebook
# ============================================================

set -g fish_greeting

# ============================================================
# ENVIRONMENT
# ============================================================

set -gx EDITOR nvim
set -gx VISUAL nvim

if not set -q XDG_CONFIG_HOME
    set -gx XDG_CONFIG_HOME ~/.config
end

if not set -q XDG_CACHE_HOME
    set -gx XDG_CACHE_HOME ~/.cache
end


# ============================================================
# INTERACTIVE SHELL
# ============================================================

if status is-interactive

    # --------------------------------------------------------
    # fzf
    # --------------------------------------------------------

    if type -q fzf
        fzf --fish | source
    end


    # --------------------------------------------------------
    # Histórico
    # --------------------------------------------------------

    if functions -q bind_M_n_history
        bind_M_n_history
    end


    # --------------------------------------------------------
    # Aparência
    # --------------------------------------------------------

    set fish_pager_color_prefix cyan
    set fish_color_autosuggestion brblack


    # --------------------------------------------------------
    # Listagem
    # --------------------------------------------------------

    if type -q eza
        abbr --add l   'eza -lh --icons=auto'
        abbr --add ls  'eza -1 --icons=auto'
        abbr --add ll  'eza -lha --icons=auto --sort=name --group-directories-first'
        abbr --add ld  'eza -lhD --icons=auto'
        abbr --add lt  'eza --icons=auto --tree'
        abbr --add lta 'eza --icons=auto --tree -a'
    end


    # --------------------------------------------------------
    # Navegação
    # --------------------------------------------------------

    abbr --add ..  'cd ..'
    abbr --add ... 'cd ../..'
    abbr --add .3  'cd ../../..'
    abbr --add .4  'cd ../../../..'
    abbr --add .5  'cd ../../../../..'

    abbr --add md 'mkdir -p'


    # --------------------------------------------------------
    # Arch / AUR
    # --------------------------------------------------------

    if type -q yay
        abbr --add up  'yay -Syu'
        abbr --add pi  'yay -S'
        abbr --add prm 'yay -Rns'
        abbr --add ps  'yay -Ss'
        abbr --add pq  'yay -Qs'
    end


    # --------------------------------------------------------
    # Git
    # --------------------------------------------------------

    abbr --add gs  'git status'
    abbr --add ga  'git add'
    abbr --add gaa 'git add --all'
    abbr --add gc  'git commit'
    abbr --add gp  'git push'
    abbr --add gpl 'git pull'
    abbr --add gl  'git log --oneline --graph --decorate'
    abbr --add gd  'git diff'

    if type -q lazygit
        abbr --add lg 'lazygit'
    end


    # --------------------------------------------------------
    # Docker
    # --------------------------------------------------------

    if type -q lazydocker
        abbr --add ldkr 'lazydocker'
    end


    # --------------------------------------------------------
    # Desenvolvimento
    # --------------------------------------------------------

    if type -q code
        abbr --add c. 'code .'
    end


    # --------------------------------------------------------
    # Busca
    # --------------------------------------------------------

    if type -q fd
        abbr --add ff 'fd'
    end

    if type -q rg
        abbr --add fg 'rg'
    end

end