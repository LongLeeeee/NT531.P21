### OpenVPN

<strong>OpenVPn</strong> là một phần mềm VPN (Virtual Private Network) và cũng là một giao thức mã hóa mạng VPN mã nguồn mở. Cung cấp một phương tiện an toàn để kết nối các thiết bị mạng thông qua internet. <strong>OpenVPN</strong> tạo ra một "đường hầm" an toàn giữa người dùng muốn truy cập để máy chủ, bảo vệ dữ liệu người dùng không bị đánh cắp khi vận chuyển trên internet. Nó xứng thực người dùng khi kết nối bằng pre-shared key,certificates hoặc tên người dùng và mật khẩu.

  <p align="center">
  <img src="openvpn_logo.png" alt="OpenVPN Logo" width="50%">
  </p>

### Triển khai

```sh
wget https://raw.githubusercontent.com/Nyr/openvpn-install/master/openvpn-install.sh
```

Đây là một file shell đã viết dành việc cài đặt OpenVPN lên máy Ubuntu. Sau khi tải thành công file tiến hành cấp quyền thực thi để cài đặt OpenVPN lên máy.

```sh
chmod +x openvpn-install.sh
sudo ./openvpn-install.sh
```

Khi thực thi file, nó sẽ yêu cầu nhập IPv4 public. Vì nhóm chọn AWS làm nơi cài đặt nên mặt định nó là địa chỉ public của máy ảo.

```sh
Welcome to this OpenVPN road warrior installer!

This server is behind NAT. What is the public IPv4 address or hostname?
Public IPv4 address / hostname [44.201.109.46]:
```

Tiếp theo là chchọn giao thức sử dụng. Đề xuất chọn UDP.

```sh
Which protocol should OpenVPN use?
   1) UDP (recommended)
   2) TCP
Protocol [1]: 1
```

Kế đến là chọn port. Bạn có thể chọn port tùy thích miễn là port đó vẫn chưa được sử dụng. Mặc định nếu không chọn thì port của OpenVPN sẽ là 1991

```sh
What port should OpenVPN listen on?
Port [1194]: 1
```

Kế đó là chọn DNS server. Chọn DNS server của Google. Bạn cũng có thể chọn các DNS server khác tùy ý.

```sh
Select a DNS server for the clients:
   1) Default system resolvers
   2) Google
   3) 1.1.1.1
   4) OpenDNS
   5) Quad9
   6) AdGuard
   7) Specify custom resolvers
DNS server [1]: 2
```

Sau các bước thiết lập bên trên thì đặt tên file (file này dùng để kết nối đến OpenVPN) cho người sử dụng muốn sử dụng OpenVPN. Và tiến hành cài đặt.

```sh
Enter a name for the first client:
Name [client]: nt531

OpenVPN installation is ready to begin.
Press any key to continue...
```

Sau khi hiển thị như bên dưới thì đã cài đặt thành công OpenVPN lên máy và file nt531.pen đã được tạo.

```sh
...
IMPORTANT: When the CRL expires, an OpenVPN Server which uses a
CRL will reject ALL new connections, until the CRL is replaced.

Created symlink /etc/systemd/system/multi-user.target.wants/openvpn-iptables.service → /etc/systemd/system/openvpn-iptables.service.
Created symlink /etc/systemd/system/multi-user.target.wants/openvpn-server@server.service → /usr/lib/systemd/system/openvpn-server@.service.

Finished!

The client configuration is available in: /home/ubuntu/nt531.ovpn
New clients can be added by running this script again.
```

### Các lựa chọn sau khi cài đặt OpenVPN thành công

Tiếp tục thực thi file <strong>openvpn-install.sh</strong>. Nó sẽ hiển thị như bên dưới với các lựa chọn.

```sh
sudo ./openvpn-install.sh
```

```sh
OpenVPN is already installed.
Select an option:
   1) Add a new client
   2) Revoke an existing client
   3) Remove OpenVPN
   4) Exit
Option:
```

<ol>
    <li> Thêm người dùng mới

Nhập tên và hiển thị như bên dưới là đã tạo thành công.

```sh
Provide a name for the client:
Name: nt531_2
...
Notice
------
Inline file created:
* /etc/openvpn/server/easy-rsa/pki/inline/private/nt531_2.inline


Notice
------
Certificate created at:
* /etc/openvpn/server/easy-rsa/pki/issued/nt531_2.crt


nt531_2 added. Configuration available in: /home/ubuntu/nt531_2.ovpn
```

  </li>

  <li>Xóa bỏ một người dùng
  
  Với option này sẽ hiển thị danh sách các các người dùng hiện có nhập số thứ tự hiển thị để xóa bỏ.
  
```sh
Select the client to revoke:
     1) nt531
     2) nt531_2
Client: 2

Confirm nt531_2 revocation? [y/N]:y

...
Notice

---

An updated CRL DER copy has been created:

- /etc/openvpn/server/easy-rsa/pki/crl.der

An updated CRL has been created:

- /etc/openvpn/server/easy-rsa/pki/crl.pem

IMPORTANT: When the CRL expires, an OpenVPN Server which uses a
CRL will reject ALL new connections, until the CRL is replaced.

nt531_2 revoked!

````

</li>

<li>Gỡ cài đặt OpenVPN

Option này sẽ gỡ OpenVPN ra khỏi máy.

```sh
OpenVPN is already installed.

Select an option:
   1) Add a new client
   2) Revoke an existing client
   3) Remove OpenVPN
   4) Exit
Option: 3

Confirm OpenVPN removal? [y/N]:y
Removed "/etc/systemd/system/multi-user.target.wants/openvpn-iptables.service".
Removed "/etc/systemd/system/multi-user.target.wants/openvpn-server@server.service".
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following package was automatically installed and is no longer required:
  libpkcs11-helper1t64
Use 'sudo apt autoremove' to remove it.
The following packages will be REMOVED:
  openvpn*
0 upgraded, 0 newly installed, 1 to remove and 82 not upgraded.
After this operation, 1798 kB disk space will be freed.
(Reading database ... 70653 files and directories currently installed.)
Removing openvpn (2.6.12-0ubuntu0.24.04.3) ...
Processing triggers for man-db (2.12.0-4build2) ...
(Reading database ... 70575 files and directories currently installed.)
Purging configuration files for openvpn (2.6.12-0ubuntu0.24.04.3) ...

OpenVPN removed!
````

</li>

</ol>
