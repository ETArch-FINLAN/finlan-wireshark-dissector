-- create myproto protocol and its fields
local name_protocol = "DL-Ontology"
finlanproto = Proto (name_protocol,name_protocol .. "Protocol")

--- declare fields
--local f_command = ProtoField.uint16("dl.command", "Command", base.HEX)
local f_data = ProtoField.string("dl.data", "Data", FT_STRING)
local f_length = ProtoField.uint16("dl.length", "length")
local f_frame = ProtoField.uint16("dl.frame", "frame")
-- f.data = ProtoField.uint16("finlanproto.data", "data")

--local f_debug = ProtoField.uint8("finlanproto.debug", "Debug")
finlanproto.fields = {f_length, f_data, f_frame}

-- myproto dissector function
function finlanproto.dissector (buf, pkt, root)

  -- validate packet length is adequate, otherwise quit
  if buf:len() == 0 then 
  return 
  end
  
  pkt.cols.protocol = name_protocol
  pkt.cols.info =  name_protocol
  -- create subtree for finlanproto
  subtree = root:add(finlanproto, name_protocol)
	  
	-- Remove optional spaces from the tags.
	--s = string.gsub(s, "/>", "/>\n")
	--s = string.gsub(s, "><", "> <")

	--a, src, b = rex.match(buf, '(<Source rdf:resource=\")(.*)("/>)')
	--a, dst, b = rex.match(buf, '(<Destination rdf:resource=\")(.*)("/>)')

  -- add protocol fields to subtree
  subtree:add(f_frame,pkt.number)
  subtree:add(f_length, buf:len())
  subtree:add(f_data,buf(0,buf:len()))
  -- description of payload
  -- add debug info if debug field is not nil
  if f_debug then
    -- write debug values
    subtree:add(f_debug, buf:len())
  end
end

-- Initialization routine
function finlanproto.init()
end

--local dissector_table = DissectorTable.get("ethertype")
local wtap_encap_table = DissectorTable.get("wtap_encap")
---local wtap_encap_table = DissectorTable.get("wtap_encap")
	--if dissector_table ~= nil then
	  --  dissector_table:add(0x8a61, finlanproto)
	 --end
--wtap_encap_table:add(wtap.ETHERNET,finlanproto)
wtap_encap_table:add(1,finlanproto)
--wtap_encap_table:add(wtap.FINLAN,finlanproto)
--dissector_table:add(0x3a61, finlanpr'oto)
