################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

import xbmcaddon
import xbmcgui

__addon__ = xbmcaddon.Addon()
__addonname__ = __addon__.getAddonInfo('name')

line1 = "Tvheadend 4.0 is no longer maintained and has been superseded by Tvheadend 4.2."
line2 = "Unfortunately upgrading from Tvh 4.0 to Tvh 4.2 is not possible. Please remove this add-on and install Tvheadend 4.2 from the LibreELEC repository."
line3 = "Apologies for the inconvenience."

xbmcgui.Dialog().ok(__addonname__, line1, line2, line3)
