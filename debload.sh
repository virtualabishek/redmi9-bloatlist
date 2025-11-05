#!/bin/bash

# ====================================================================================
# A SAFER XIAOMI (MIUI) DEBLOATING SCRIPT
#
# REORGANIZED AND COMMENTED TO PREVENT BOOT LOOPS AND SYSTEM INSTABILITY.
# The script is divided into three sections:
# 1. DO NOT REMOVE: Critical packages that were in your original list. They are
#    here for reference only and will NOT be removed.
# 2. USE WITH CAUTION: Packages that can be removed, but will disable specific
#    features. This section is COMMENTED OUT by default.
# 3. SAFE TO REMOVE: General bloatware, ad services, and redundant apps that can
#    be removed without harming the system. This is the only list that runs
#    by default.
# ====================================================================================


# SECTION 1: DO NOT REMOVE
# These packages were in your original script but are critical. Removing them is
# a primary cause of boot loops or system failure. They are listed here so you
# know what to AVOID.
#
# declare -a do_not_remove=(
#
#   com.xiaomi.account                  # CRITICAL: Manages Mi Account, essential for many services.
#   com.android.updater                 # CRITICAL: Required for receiving and installing system OTA updates.
#   com.android.thememanager            # CRITICAL: Manages all themes, icons, and fonts in MIUI.
#   com.miui.daemon                     # HIGHLY UNSTABLE: Deeply integrated system daemon. You already had to restore this.
#   com.google.android.inputmethod.latin  # CRITICAL (IF NO ALTERNATIVE): This is Gboard. Removing it without another
#                                       # keyboard installed and active will leave you with NO WAY TO TYPE.
# )


# SECTION 2: USE WITH CAUTION
# These packages disable specific features you might use.
# To remove any of these, DELETE the '#' from the beginning of the line.
# Review each one carefully and decide if you need the feature.
#
declare -a use_with_caution=(

#   com.miui.cloudservice               # Mi Cloud core service. Remove this and all other "cloud" packages if you don't use Mi Cloud.
#   com.miui.cloudbackup                # Mi Cloud backup functionality.
#   com.miui.micloudsync                # Mi Cloud sync functionality.
#   com.miui.cloudservice.sysbase       # Mi Cloud system base.
#   com.miui.gallery                    # Default MIUI Gallery app. System may still try to call it. Remove only if you have an alternative.
#   com.android.deskclock               # The default Clock app (alarms, timer). Do not remove unless you have a reliable alternative.
#   com.xiaomi.joyose                   # A performance/gaming service. Some users report issues after removal.
#   com.miui.cit                        # Hardware test mode (CIT). Useful for diagnostics.
#   com.miui.misound                    # Sound effects and equalizer settings (Dirac). Sound quality might change if removed.
#   com.miui.audioeffect                # Related to audio effects.
#   com.miui.freeform                   # Floating windows feature.
#   com.miui.touchassistant             # The "Quick Ball" floating assistant.
#   com.google.android.projection.gearhead # Android Auto.
#   com.android.printspooler            # Service for printing documents from your phone.
#   com.android.emergency               # Manages emergency contacts and SOS features.
)


# SECTION 3: SAFE TO REMOVE
# This list contains third-party bloat, ad services, analytics, and redundant
# Xiaomi/Google apps that can be removed without causing system instability.
# This is the primary list that the script will process.
#
declare -a safe_to_remove=(

# --- Analytics and Ad Services ---
com.miui.analytics
com.miui.msa.global
com.miui.systemAdSolution

# --- Pre-installed Third-Party Apps ---
in.amazon.mShop.android.shopping
com.facebook.appmanager
com.facebook.services
com.facebook.system
com.facebook.katana
com.netflix.partner.activation
com.netflix.mediaclient
com.booking
com.linkedin.android
com.igg.android.lordsmobile
cn.wps.moffice_eng
cn.wps.xiaomi.abroad.lite
com.funnypuri.client

# --- Redundant/Unused Google Apps ---
com.google.android.apps.docs
com.google.android.apps.maps
com.google.android.apps.photos
com.google.android.apps.tachyon         # Google Duo (video calling)
com.google.android.apps.subscriptions.red # YouTube Premium
com.google.android.music
com.google.android.apps.youtube.music
com.google.android.videos               # Google TV (Play Movies & TV)
com.google.android.apps.googleassistant
com.google.android.gm                   # Gmail
com.google.android.googlequicksearchbox # Google Search bar and Discover feed
com.google.ar.lens
com.google.android.apps.nbu.paisa.user  # Google Pay (Tez for India)
com.google.android.youtube
com.google.android.calendar
com.google.android.apps.walletnfcrel    # Google Wallet
com.google.android.apps.messaging
com.google.android.apps.restore
com.google.android.apps.turbo           # Device Health Services
com.google.android.tts                  # Text-to-speech engine
com.google.android.feedback
com.google.android.syncadapters.contacts # Syncs contacts with Google account. Keep if you use Google contacts.

# --- Redundant/Bloat MIUI System Apps ---
com.milink.service
com.miui.audiomonitor
com.miui.bugreport
com.miui.contentcatcher
com.miui.hybrid
com.miui.hybrid.accessory
com.miui.maintenancdemode
com.miui.miservice
com.miui.mishare.connectivity
com.miui.nextpay
com.miui.personalassistant
com.miui.phrase
com.miui.smsextra
com.miui.translation.kingsoft
com.miui.translation.xmcloud
com.miui.translation.youdao
com.miui.translationservice
com.miui.voiceassist
com.miui.voicetrigger
com.miui.vsimcore
com.miui.wmsvc
com.mobiletools.systemhelper
com.miui.android.fashiongallery
com.miui.mediaeditor
com.android.fmradio
com.miui.fm
com.mipay.wallet.in
com.micredit.in
com.mi.globalbrowser
com.mi.android.globalminusscreen        # App Vault / Discover screen on the left of home
com.mi.android.globalFileexplorer
com.miui.backup
com.miui.calculator
com.miui.cleanmaster
com.miui.compass
com.miui.notes
com.miui.player
com.android.soundrecorder
com.miui.screenrecorder
com.miui.videoplayer
com.miui.weather2
com.miui.yellowpage
com.xiaomi.calendar
com.xiaomi.glgm
com.xiaomi.midrop
com.xiaomi.mipicks
com.xiaomi.miplay_client
com.xiaomi.mirecycle
com.xiaomi.payment
com.xiaomi.scanner
com.duokan.phone.remotecontroller       # Mi Remote
com.miui.newmidrive
com.xiaomi.mircs
com.xiaomi.discover
org.mipay.android.manager

# --- Other System Components (Generally safe to remove) ---
com.android.egg                         # Android Version Easter Egg
com.android.wallpaperbackup
com.android.musicfx                     # Legacy audio effects library
com.tencent.soter.soterserver
com.android.providers.downloads.ui      # The UI for the Downloads app
)


# ====================================================================================
# SCRIPT EXECUTION LOGIC
# ====================================================================================

# WAIT FOR A DEVICE TO CONNECT
clear
tput civis # Hide the cursor
echo "This $(tput setaf 6)safer bash$(tput sgr0) script will remove bloatware from your Xiaomi device."
echo ""
echo "$(tput setaf 3)Please ensure your phone has USB Debugging enabled.$(tput sgr0)"
echo "Waiting ⏳ for a device to be connected..."
adb wait-for-device

# TAKE DEVICE MARKET NAME
device_name=$(adb shell getprop ro.product.odm.marketname)
if [ -z "$device_name" ]; then
    device_name="$(adb shell getprop ro.product.manufacturer) $(adb shell getprop ro.product.model)"
fi
clear
echo "Device Connected: $(tput setaf 2)$device_name$(tput sgr0)"
echo ""
sleep 2

# --- UNINSTALL SAFE APPS ---
echo "$(tput bold)$(tput setaf 2)--- Removing SAFE packages ---$(tput sgr0)"
for pkg in "${safe_to_remove[@]}"
do
    echo "🛁 Removing: $(tput setaf 6)$pkg$(tput sgr0)"
    adb shell pm uninstall -k --user 0 "$pkg" > /dev/null 2>&1
done
echo "$(tput setaf 2)Safe packages removed.$(tput sgr0)"
echo ""


# --- UNINSTALL CAUTION APPS ---
if [ ${#use_with_caution[@]} -gt 0 ]; then
    echo "$(tput bold)$(tput setaf 3)--- Removing CAUTION packages you enabled ---$(tput sgr0)"
    for pkg in "${use_with_caution[@]}"
    do
        echo "🤔 Removing: $(tput setaf 6)$pkg$(tput sgr0)"
        adb shell pm uninstall -k --user 0 "$pkg" > /dev/null 2>&1
    done
    echo "$(tput setaf 3)Caution packages removed.$(tput sgr0)"
    echo ""
fi

tput cnorm # Show the cursor again
echo "$(tput bold)$(tput setaf 2)✅ Debloating process complete!$(tput sgr0)"
echo "It is recommended to reboot your device now."