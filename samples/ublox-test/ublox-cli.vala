
/*
 * Copyright (C) 2014 Jonathan Hudson <jh+mwptools@daria.co.uk>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */


/* Based on the Multiwii UBLOX parser, GPL by a cast of thousands */

extern int  init_signals();

static MainLoop ml;
static MWSerial msp;

void show_stats(MWSerial s)
{
    var st = s.getstats();
    stderr.puts("\n");
    MWPLog.message("%.0fs, rx %lub, tx %lub, (%.0fb/s, %0.fb/s)\n",
                   st.elapsed, st.rxbytes, st.txbytes,
                   st.rxrate, st.txrate);
    stderr.puts("\n");
}

private bool sig_reader (IOChannel gio, IOCondition condition)
{
    int s=0;
    var ret = Posix.read(gio.unix_get_fd(), &s, sizeof(int));
    if(ret != sizeof(int))
        return false;
    show_stats(msp);
    if(s == 2 /*Posix.SIGINT*/)
        ml.quit();
    return true;
}

public static int main (string[] args)
{
    ml = new MainLoop();
    msp = new MWSerial();

    if (msp.parse_option(args) == 0)
    {
        if(msp.ublox_open(MWSerial.devname, MWSerial.brate))
        {
            int pfd = init_signals();
            if(pfd != -1)
            {
                var io_read  = new IOChannel.unix_new(pfd);
                io_read.add_watch(IOCondition.IN, sig_reader);
            }
            ml.run();
        }
    }
    return 0;
}
