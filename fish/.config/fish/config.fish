# ============================================================
# Nyx — Fish
# Configuração compartilhada entre desktop e notebook
# ============================================================

set -g fish_greeting


# ============================================================
# ENVIRONMENT
# ============================================================

set -gx EDITOR code

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
    # Starship
    # Só carrega se estiver instalado nesta máquina
    # --------------------------------------------------------

    if type -q starship
        set -gx STARSHIP_CACHE "$XDG_CACHE_HOME/starship"
        set -gx STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"

        starship init fish | source
    end


    # --------------------------------------------------------
    # fzf
    # --------------------------------------------------------

    if type -q fzf
        fzf --fish | source
    end


    # --------------------------------------------------------
    # Histórico
    # Alt+n -> nth command from history
    # --------------------------------------------------------

    if functions -q bind_M_n_history
        bind_M_n_history
    end

end


# ============================================================
# APARÊNCIA DO FISH
# ============================================================

set fish_pager_color_prefix cyan
set fish_color_autosuggestion brblack


# ============================================================
# LISTAGEM DE ARQUIVOS
# ============================================================

if type -q eza
    abbr --add l  'eza -lh --icons=auto'
    abbr --add ls 'eza -1 --icons=auto'
    abbr --add ll 'eza -lha --icons=auto --sort=name --group-directories-first'
    abbr --add ld 'eza -lhD --icons=auto'
    abbr --add lt 'eza --icons=auto --tree'
end


# ============================================================
# NAVEGAÇÃO
# ============================================================

abbr --add ..  'cd ..'
abbr --add ... 'cd ../..'
abbr --add .3  'cd ../../..'
abbr --add .4  'cd ../../../..'
abbr --add .5  'cd ../../../../..'


# ============================================================
# CRIAÇÃO
# ============================================================

# mkdir continua sendo o comando Unix normal.
# md é apenas um atalho explícito para mkdir -p.

abbr --add md 'mkdir -p'


# ============================================================
# PACOTES — ARCH / AUR
# ============================================================

if type -q yay
    abbr --add up  'yay -Syu'
    abbr --add pi  'yay -S'
    abbr --add prm 'yay -Rns'
    abbr --add ps  'yay -Ss'
    abbr --add pq  'yay -Qs'
end


# ============================================================
# GIT
# ============================================================

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


# ============================================================
# DOCKER
# ============================================================

if type -q lazydocker
    abbr --add ldkr 'lazydocker'
end


# ============================================================
# APLICAÇÕES / DESENVOLVIMENTO
# ============================================================

if type -q code
    abbr --add c. 'code .'
end


# ============================================================
# BUSCA
# ============================================================

# Ctrl+R continua sendo a busca de histórico do Fish.
# fd, rg e fzf continuam disponíveis com seus comandos normais.

if type -q fd
    abbr --add ff 'fd'
end

if type -q rg
    abbr --add fg 'rg'
end
