# deltaskin-template

###### by [N. Escobar](https://nickesc.github.io)/[nickesc](https://github.com/nickesc)

## Intro

A template and build system for creating skins for the [Delta emulator](https://github.com/rileytestut/Delta).

Use this as a starting point for creating skins for Delta. It is set up to make the process as easy as possible for you, including a build script to compress skins into a `.deltaskin` file and templates to start building skins for every system.

There are also a number of other quality of life benefits to using this build system:
- automatic backups of pervious builds; never overwrite an old version accidentally
- lossless compression; you're loosing quality on your `.pdf`s and `.png`s when you compress them with default settings
- test scripts; send the `.deltaskin` files in your `build/` directory to your iCloud Drive for testing on a mobile device (more coming soon)
- build all skins for all systems at once
- build skins for systems individually (TODO)
- generate info.json files with the correct name and identifiers automatically (TODO)

The templates themselves are just the Standard Delta skins available by defualt with the app and made by the Delta developers. Use them as a jumping off point and to see how skins are made.

> *I am in no way associated with [Delta](https://github.com/rileytestut/Delta) or [rileytestut](https://github.com/rileytestut). This is a toolkit I built in a night to make creating skins easier. All credit for the emulator and skin system goes to the developers of the [Delta emulator](https://github.com/rileytestut/Delta).*


## How to Use

#### Requirements
- `bash` (tested `4.0+`): language for build scripts
- `npm` (tested `10.2.4+`): package manager used to execute scripts

### Step one:

Clone this repository:

```sh
git clone https://github.com/nickesc/deltaskin-template
```


### Step two:

Edit the environment variables stored in `build.env` and `build.sh` -- these are important if you want your `.deltaskin` files to be named correctly:

``` sh
# build.env

# The path to your build directory (defaults to './build/'); can
# be changed if you want to build somewhere else
export BUILD_DIR="build"

# The path to your build backup directory (defaults to './backup/');
# can be changed if you want to backup somewhere else
export BACKUP_DIR="backup"

# The path to the directory in your project where skin folders are 
# stored (defaults to './deltaskin/'); can be changed if you want
# to store them somewhere else
export DELTASKIN_DIR="deltaskin"

# The directory in your iCloud Drive (or other location) you want
# to copy builds of skins to; can be changed if you want to copy
# to another location
export ICLOUD_DELTASKIN_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Emulation/Delta/skins"

# The systems to build skins for -- must match the system folder name
export DELTASKINS=("$DELTASKIN_DIR/gba" "$DELTASKIN_DIR/gbc" "$DELTASKIN_DIR/n64" "$DELTASKIN_DIR/nds" "$DELTASKIN_DIR/nes" "$DELTASKIN_DIR/snes")
```

``` sh
# skin.env

# The skin's author
export AUTHOR="rileytestut"

# The full name of the skin
export DELTASKIN_NAME="Standard"

# The abbreviation of the skin name for use in identifiers
export DELTASKIN_ABR="Standard"

# The reverse-dns format prefix for your skin's identifier
export ID_PREFIX="com.delta"
```


### Step three:

Create your skin!

Edit skin information in `info.json` files and replace graphics with your own.


### Step four:

Build your skins:

```sh
npm run build
```

### Step five:

Send your skins to iCloud:

```sh
npm run send
```

### Step six:

Open skin files in Delta and select them from `Settings > Controller Skins`

Test them in game to make sure they are functioning how you expect!

## License

Like [Delta itself](https://github.com/rileytestut/Delta#Licensing), this project is released under the [AGLPv3 license](https://github.com/nickesc/deltaskin-template/blob/main/LICENSE). 

## Reference:

- [***Delta Custom Skins***](https://noah978.gitbook.io/delta-docs/skins) by Noah Keck ([noah978](https://github.com/noah978))
