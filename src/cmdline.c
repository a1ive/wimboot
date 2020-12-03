/*
 * Copyright (C) 2014 Michael Brown <mbrown@fensystems.co.uk>.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301, USA.
 */

/**
 * @file
 *
 * Command line
 *
 */

#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include "wimboot.h"
#include "cmdline.h"

/** CD-ROM int13 drive number */
int cmdline_cdrom;

/** Use raw (unpatched) BCD files */
int cmdline_rawbcd;

/** Use raw (unpatched) WIM files */
int cmdline_rawwim;

/** Allow graphical output from bootmgr/bootmgfw */
int cmdline_gui;

/** Pause before booting OS */
int cmdline_pause;

/** Pause without displaying any prompt */
int cmdline_pause_quiet;

/** WIM boot index */
unsigned int cmdline_index;

/**
 * Process command line
 *
 * @v cmdline		Command line
 */
void process_cmdline ( char *cmdline ) {
	char *tmp = cmdline;
	char *key;
	char *value;
	char *endp;

	/* Do nothing if we have no command line */
	if ( ( cmdline == NULL ) || ( cmdline[0] == '\0' ) )
		return;
	DBG ( "Command line: \"%s\"\n", cmdline );

	/* Parse command line */
	while ( *tmp ) {

		/* Skip whitespace */
		while ( isspace ( *tmp ) )
			tmp++;

		/* Find value (if any) and end of this argument */
		key = tmp;
		value = NULL;
		while ( *tmp ) {
			if ( isspace ( *tmp ) ) {
				*(tmp++) = '\0';
				break;
			} else if ( *tmp == '=' ) {
				*(tmp++) = '\0';
				value = tmp;
			} else {
				tmp++;
			}
		}

		/* Process this argument */
		if ( strcmp ( key, "rawbcd" ) == 0 ) {
			cmdline_rawbcd = 1;
		} else if ( strcmp ( key, "rawwim" ) == 0 ) {
			cmdline_rawwim = 1;
		} else if ( strcmp ( key, "gui" ) == 0 ) {
			cmdline_gui = 1;
		} else if ( strcmp ( key, "pause" ) == 0 ) {
			cmdline_pause = 1;
			if ( value && ( strcmp ( value, "quiet" ) == 0 ) )
				cmdline_pause_quiet = 1;
		} else if ( strcmp ( key, "index" ) == 0 ) {
			if ( ( ! value ) || ( ! value[0] ) )
				die ( "Argument \"index\" needs a value\n" );
			cmdline_index = strtoul ( value, &endp, 0 );
			if ( *endp )
				die ( "Invalid index \"%s\"\n", value );
		} else if ( strcmp ( key, "cdrom" ) == 0 ) {
			if ( ( ! value ) || ( ! value[0] ) )
				die ( "Argument \"cdrom\" needs a value\n" );
			cmdline_cdrom = strtoul ( value, &endp, 0 );
			if ( *endp )
				die ( "Invalid cdrom \"%s\"\n", value );
		} else if ( strcmp ( key, "initrdfile" ) == 0 ) {
			/* Ignore this keyword to allow for use with syslinux */
		} else if ( key == cmdline ) {
			/* Ignore unknown initial arguments, which may
			 * be the program name.
			 */
		} else {
			die ( "Unrecognised argument \"%s%s%s\"\n", key,
			      ( value ? "=" : "" ), ( value ? value : "" ) );
		}
	}
}
