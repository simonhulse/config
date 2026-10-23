function phone-umount
    if not set -q PHONE_MTP_URI
        echo "phone-umount: PHONE_MTP_URI is not set (set -U PHONE_MTP_URI mtp://...)" >&2
        return 1
    end

    gio mount -u $PHONE_MTP_URI
end
