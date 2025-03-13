module("luci.controller.zerotier",package.seeall)

function index()
  if not nixio.fs.access("/etc/config/zerotier")then
return
end

entry({"admin","zt"}, firstchild(), "ZT", 88).dependent = false

entry({"admin", "zt", "zerotier"},firstchild(), _("ZeroTier")).dependent = false

entry({"admin", "zt", "zerotier", "general"},cbi("zerotier/settings"), _("Base Setting"), 1)
entry({"admin", "zt", "zerotier", "log"},form("zerotier/info"), _("Interface Info"), 2)
entry({"admin", "zt", "zerotier", "manual"},cbi("zerotier/manual"), _("Manual Config"), 3)

entry({"admin","zt","zerotier","status"},call("act_status"))
end

function act_status()
local e={}
  e.running=luci.sys.call("pgrep /usr/bin/zerotier-one >/dev/null")==0
  luci.http.prepare_content("application/json")
  luci.http.write_json(e)
end
#####
