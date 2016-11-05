# Get Dark-Elixir

期待した人には申し訳ないですが、掲題で書いているほどちゃんとした内容ではありません。
簡単に説明しますと、NeoVim+dein.vim+elixirの開発環境がほしいなーって思ったので、環境構築するだけの記事です。

それと最初に言っておきます。
Vim初心者なので、間違っている部分もあると思いますので、あらかじめご了承ください。
またその場合は優しく全力でマサカリを振ってください。(混乱)

## Goal

- ダークパワーを手に入れる
- エリクサーにダークパワーを注入してダークエリクサーにする

#### Translate

- NeoVimでdein.vimを使う
- パッケージ管理(dein.vim)を使って、Elixirの開発環境を整える

## As a prerequisite for

下記のツール・アプリケーションがインストール済みであること。

- Erlang/OTP
- Elixir
- Git

## Dev-Env

- MacOS: v10.11.6
- Git: v2.7.4
- Erlang/OTP: v19.1
- Elixir: v1.3.3
- NeoVim: v0.1.6
  * dein.vim: v0.5(?)
- Python: v3.5 and v2.7

## プラグイン一覧 (Plugin list)

導入予定のプラグイン一覧。

- dein.toml
  - Shougo/dein.vim
  - Shougo/vimproc.vim
  - Shougo/vimshell.vim
  - Shougo/context_filetype.vim
  - hail2u/vim-css3-syntax
  - thinca/vim-ref
  - elixir-lang/vim-elixir
  - slashmili/alchemist.vim
  - cespare/vim-toml
  - elzr/vim-json
  - rcmdnk/vim-markdown
  - vim-ruby/vim-ruby
  - jelera/vim-javascript-syntax
- dein_lazy.toml
  - Shougo/neomru.vim
  - Shougo/unite.vim
  - Shougo/neoyank.vim
- dein_neo.toml
  - Shougo/deoplete.nvim

## NeoVimをインストールする (in HomeBrew)

まずはNeoVimのインストールからです。特にビルドとかはしたりしないです。
めんどくさがりなのでHomeBrewを使ってインストールします。

### NeoVim

#### Example:

```cmd
$ brew install neovim/neovim/neovim
```

はい終わり。

### Python3

deoplete.nvimというダークパワーを高める素晴らしいプラグインを使うので、Python3を入れます。

#### Example:

```cmd
$ brew install python
$ pip install neovim
         or
$ pip install --upgrade neovim

$ brew install python3
$ pip3 install neovim
         or
$ pip3 install --upgrade neovim
```

Pythonがインストールされたか確認してみましょう。
Requireに示されているのはpython3でしたが、
CheckHealthしたときにエラー出てたので一応、pythonの方も入れておきます。

インストールを確認します。

#### Example:

```cmd
$ nvim
```

コマンドモードで下記のコマンドを実行し、1が戻ってくれば問題ありません。

#### Example:

```vim
:echo has('python')
1
```

```vim
:echo has('python3')
1
```

#### Note: vimならインストール時のオプションでluaをonにできるけど、nvimでのluaの入れ方がわからない。公式ドキュメントとかもまだ全然読めてないので、後に確認します。

### Env (環境変数)

環境変数：XDG_CONFIG_HOME を設定します。(多分ないと動かないはず・・・)
下記の内容を追加してください。

#### File: .bash_profile or .zshrc

```bash
export XDG_CONFIG_HOME=$HOME/.config
```

#### Example:

```cmd
source ~/.bash_profile or ~/.zshrc
```

NeoVimでは、$XDG_CONFIG_HOME/nvim/init.vimという形で設定ファイルを置くとのこと。
現在は作成されていませんので、ディレクトリとファイルを作成します。

#### Example:

```cmd
$ cd $XDG_CONFIG_HOME
$ mkdir nvim
$ cd nvim
$ touch init.vim
$ ls
```

## 闇の力を手に入れる

それでは闇の力を手に入れましょう。
生贄を捧げるのです・・・。(何を捧げればいいんでしょうか？人間性？？？人生か！？)

生贄は後で捧げればいいでしょう。dein.vimを手に入れてから考えます。

#### Example:

```cmd
$ cd ~/.cache
$ mkdir -p dein/repos/github.com/Shougo/
$ cd ~/dein/.cache/dein/repos/github.com/Shougo
$ git clone https://github.com/Shougo/dein.vim.git
```

init.vimに下記を記載します。

#### Example:

```cmd
$ cd $XDG_CONFIG_HOME/nvim
$ nvim init.vim
```

#### File: $XDG_CONFIG_HOME/nvim/init.vim

```vim
" dein.vim関係のパス
let s:dein_cache_dir = expand('~/.cache/dein')
let s:dein_config_dir = expand('~/.config/nvim/dein')
let s:dein_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

" vi互換を無効にする
if &compatible
  set nocompatible
endif
" ランタイムパスにdein.vimを追加する
execute 'set runtimepath^=' . s:dein_dir

" dein.vimの設定
call dein#begin(s:dein_cache_dir)

call dein#add('Shougo/dein.vim')

call dein#end()

" 必須設定
syntax enable
filetype plugin indent on
```

コマンドモードで下記を実行する。

#### Example:

```vim
:call dein#install()
```

nvimでinit.vimを開き直して、エラーを示すメッセージ表示されていなければ大丈夫だと思います。
これで闇の力を手に入れることができました。

## 闇の力を高める

闇の力をさらに求めます。
生贄もさらに多く必要になるので気をつけて下さい。

ここで行うのは、pluginsの設定をtomlファイルで管理できるようにすることです。
私の場合ですが、$XDG_CONFIG_HOME/nvimの配下にdeinディレクトリを置いて管理しています。
何が良いやり方なのか、よくわかっていないところがありますので、ご自身の環境に合わせてしまって構いません。
(多分、Shougo氏が公開しているリポジトリを参考にするのが一番いいんだと思います)

一応、参考までに・・・

#### Example:

```cmd
$ cd $XDG_CONFIG_HOME/nvim
$ mkdir dein
$ cd ./dein
$ touch .dein.toml
$ touch .dein_lazy.toml
$ touch .dein_neo.toml
```

init.vimの内容を下記のように修正してください。

#### File: $XDG_CONFIG_HOME/nvim/init.vim

```vim
let s:dein_cache_dir = expand('~/.cache/dein')
let s:dein_config_dir = expand('~/.config/nvim/dein')
let s:dein_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

if &compatible
  set nocompatible
endif
execute 'set runtimepath^=' . s:dein_dir

if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

  let s:toml      = s:dein_config_dir . '/.dein.toml'
  let s:lazy_toml = s:dein_config_dir . '/.dein_lazy.toml'
  let s:neo_toml  = s:dein_config_dir . '/.dein_neo.toml' 

  " プラグインの読み込み
  call dein#load_toml(s:toml, {'lazy': 0})
  if has('nvim')
    call dein#load_toml(s:neo_toml, {})
  endif
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" hook_sourceに設定している内容を展開する
call dein#call_hook('source')

syntax enable
filetype plugin indent on

" プラグインのインストールチェック
if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

if dein#check_install()
  call dein#install()
endif
```

.dein.tomlの内容は下記の通りです。

#### File: $XDG_CONFIG_HOME/nvim/dein/.dein.toml

```toml
[[plugins]]
repo = 'Shougo/dein.vim'

[[plugins]]
repo = 'Shougo/vimproc.vim'
build = 'make'

[[plugins]]
repo = 'cespare/vim-toml'
on_ft = ['toml']
```

一度修正して、.dein.tomlを開き直してください。
反映されない場合は、コマンドモードで下記のコマンドを実行してみてください。

#### Example:

```vim
:call dein#clear_state()
:call dein#update()
```

tomlファイルにシンタックスハイライトが付いていれば大丈夫です。

## 闇の力をもっと高める

さらなる闇の力を求めて・・・

他のプラグインを導入し、闇の力をもっと高めていきましょう。
生贄？知らない子です！そんなことよりダークパワーの高まりを感じましょう！

自分の環境に必要のないプラグインがあれば削除してしまってください。
(私が必要なプラグインを入れています。)

#### File: $XDG_CONFIG_HOME/nvim/dein/.dein_lazy.toml

```toml
[[plugins]]
repo = 'Shougo/dein.vim'

[[plugins]]
repo = 'Shougo/vimproc.vim'
build = 'make'

[[plugins]]
repo = 'Shougo/vimshell.vim'

[[plugins]]
repo = 'Shougo/context_filetype.vim'

[[plugins]]
repo = 'hail2u/vim-css3-syntax'

[[plugins]]
repo = 'thinca/vim-ref'

[[plugins]]
repo = 'cespare/vim-toml'
on_ft = ['toml']

[[plugins]]
repo = 'elzr/vim-json'
on_ft = 'json'

[[plugins]]
repo = 'rcmdnk/vim-markdown'
on_ft = ['markdown', 'mkd']

[[plugins]]
repo = 'vim-ruby/vim-ruby'
on_map = '<Plug>'
on_ft = 'ruby'

[[plugins]]
repo = 'jelera/vim-javascript-syntax'
on_ft = 'javascript'
```

#### File: $XDG_CONFIG_HOME/nvim/dein/.dein_lazy.toml

```toml
[[plugins]]
repo = 'Shougo/neomru.vim'
on_path = '.*'

[[plugins]]
repo = 'Shougo/unite.vim'
depends = 'neomru.vim'

[[plugins]]
repo = 'Shougo/neoyank.vim'
```

deopleteの設定を記述するためのファイルを用意します。
ことのついでにプラグイン固有の設定を管理するディレクトリも用意してしまいます。

#### Example:

```cmd
$ cd $XDG_CONFIG_HOME/nvim/dein
$ mkdir plugins
$ touch deoplete.vim
```

#### File: $XDG_CONFIG_HOME/nvim/dein/plugins/deoplete.vim

```vim
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#enable_smart_case = 1
```

#### File: $XDG_CONFIG_HOME/nvim/dein/.dein_neo.toml

```toml
[[plugins]]
repo = 'Shougo/deoplete.nvim'
depends = 'context_filetype.vim'
if = "has('nvim')"
hook_source = '''
  let g:deoplete#enable_at_startup = 1
  source ~/.config/nvim/dein/plugins/deoplete.vim
'''
```

#### Note: もしinit.vimに"set paste"が記述してある方がいたらコメントアウトしてください。補完が効かなくなります(作者様より仕様と伺っています)

これで(私に)必要なプラグインはだいだい用意できました。
しかし、まだ残っています。そう！Elixirの環境です。
この次でやっていきます。

## ダークエリクサーの実験

やっとここまできました。いよいよ念願のダークエリクサーまで手が届きます。
具体的には、Elixirのソースコードでハイライトと補完、ドキュメント参照ができることです。

.dein.tomlにプラグインを追加します。

#### File: $XDG_CONFIG_HOME/nvim/dein/.dein.toml

```toml
...

[[plugins]]
repo = 'elixir-lang/vim-elixir'
on_ft = ['elixir']

[[plugins]]
repo = 'slashmili/alchemist.vim'
depends = 'vim-elixir'
on_ft = ['elixir']
```

deopleteの設定にも下記を追記してください。

#### File: $XDG_CONFIG_HOME/nvim/dein/plugins/deoplete.vim

```vim
...

let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'tag']
let g:deoplete#sources.elixir = ['alchemist']
```

### インデントと補完

インデントと補完の確認をしてみましょう。
vim-elixir、alchemist.vim、deoplete.nvimが正常に機能していれば下記のようなになります。

<div class="separator" style="clear: both; text-align: center;">
<a href="https://4.bp.blogspot.com/-NgMNhVReeJQ/WB31mm618mI/AAAAAAAAAcQ/0ScOkpR1U3ww7nRH8I7l0SKo8gm9jPBJgCLcB/s1600/alchemist_001.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" height="204" src="https://4.bp.blogspot.com/-NgMNhVReeJQ/WB31mm618mI/AAAAAAAAAcQ/0ScOkpR1U3ww7nRH8I7l0SKo8gm9jPBJgCLcB/s320/alchemist_001.png" width="320" /></a></div>
<br />

deopleteが自動補完してくれていますが、一応コマンドも知っておいた方がいいでしょう。
デフォルトでは、＜Ctrl-x＞＜Ctrl-o＞を連続入力が手動補完のコマンドになります。

あぁ素晴らしきかなdeoplete.nvim！(ダークパワー万歳！)

### ドキュメントの参照

関数の引数や使い方を忘れてしまった・・・そんなことはありませんか？
私の場合はたびたびあり、そのたびにドキュメントを見にいきます。
そんなときに使える機能だと思います。

インサートモードで、モジュールもしくは関数にカーソルを合わせてK(Shift+k)を入力してください。
下図のように、別画面でドキュメントが出て来れば大丈夫です。

<div class="separator" style="clear: both; text-align: center;">
<a href="https://1.bp.blogspot.com/-de-AxN_zrs4/WB31muMbUYI/AAAAAAAAAcU/zhRUjDEH2xAF7XPBZWJc-yP68yEBcVUUACLcB/s1600/alchemist_002.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" height="205" src="https://1.bp.blogspot.com/-de-AxN_zrs4/WB31muMbUYI/AAAAAAAAAcU/zhRUjDEH2xAF7XPBZWJc-yP68yEBcVUUACLcB/s320/alchemist_002.png" width="320" /></a></div>

## おわりに

一人でdeopleteが動かせなかった弱小プログラマです。(全ては私の力不足ゆえ)
作者様からご助言をいただき、なんとかここまでできました。
このような場ですが、感謝の意を示させていただきます。本当にありがとうございます。

またお恥ずかしながら、今に至るまでVimもNeoVimもプラグインを入れる機会がなかったもので、知識や知見が致命的に足りません。(FATAL状態ですよ！)
なので、おすすめのプラグインなどがあれば教えていただけますと幸いです。

おめーの入れ方間違ってるからとか、その設定の書き方はちょっと・・・というようなメッセージでも構いません。
全ては不勉強なわたしがいけないのです。

習熟度が低いのでまだまだ快適とは言えないのですが、少しずつ慣れていけばいいでしょう。
目指すはnvimでの快適Elixirライフ！！

## 参考
[https://neovim.io/](https://neovim.io/)
[https://github.com/Shougo/dein.vim](https://github.com/Shougo/dein.vim)
[https://github.com/Shougo/deoplete.nvim](https://github.com/Shougo/deoplete.nvim)
[https://github.com/slashmili/alchemist.vim/wiki](https://github.com/slashmili/alchemist.vim/wiki)
[https://github.com/Shougo/shougo-s-github](https://github.com/Shougo/shougo-s-github)
