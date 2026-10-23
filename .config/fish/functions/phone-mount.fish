function phone-mount
    if not set -q PHONE_MTP_URI
        echo "phone-mount: PHONE_MTP_URI is not set (set -U PHONE_MTP_URI mtp://...)" >&2
        return 1
    end

    if gio mount $PHONE_MTP_URI
        ls /run/user/(id -u)/gvfs/
    else
        echo "phone-mount: failed - is the phone plugged in and unlocked?" >&2
        return 1
    end
end
