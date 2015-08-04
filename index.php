<?php include "../head.html"; ?>
<body bgcolor="#ffffff">
<p>Please enter userid on server, hostname(or IPaddress) and its password to view graphical view of memory utilization (sar -r)</p>
<form method="post" name="form" action="/cgi-bin/connect_to_server.pl" target=_top>
<p>&nbsp;</p>

<select name=sarc>
<option value=1>cpu usage</option>
</select>
<p>userid&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input name=userid></p>
<p>hostname&nbsp;&nbsp;&nbsp; &nbsp;<input name="hostname"></p>
<p>password&nbsp;&nbsp; &nbsp; <input type="password" name="pwd"></p>
<p><input value="Submit" type="submit" name="submit"><input value="Reset" type="reset" name="reset">
</form></p>


<?php include "../tail.html"; ?>
