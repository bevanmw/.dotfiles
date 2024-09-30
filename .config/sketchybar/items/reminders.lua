local settings = require("settings")
local icons = require("icons")
local colors = require("colors")

local popup_width = 250
local popup_height = 25

local count = sbar.add("item", {
  position = "right",
  padding_left = 0,
  padding_right = 0,
  label = {
    font = { size = 9 },
    max_chars = 24,
  }
})

local reminders = sbar.add("item", {
  position = "right",
  padding_left = 3,
  padding_right = 0,
  label = {
    font = { size = 13 },
    max_chars = 24,
  },
  popup = { height = popup_height },
  icon = {
    string = icons.reminder,
    align = "left",
    color = colors.grey,
    font = {
      style = settings.font.style_map["Regular"],
      size = 14.0,
    },
  },
})


reminders:set({ label = 'Reminders' })

local function clear_reminder_lists()
  sbar.remove('/reminders.Overdue\\.*/')
  sbar.remove('/reminders.Today\\.*/')
  sbar.remove('/reminders.Upcoming\\.*/')
end

local function add_reminder_list(list, name, color)
  sbar.add("item", "reminders." .. name, {
    position = "popup." .. reminders.name,
    width = popup_width,
    align = "center",
    label = { string = name },
  })

  counter = 0
  for _, reminder in ipairs(list) do
    sbar.add("item", "reminders." .. name .. "." .. counter , {
      position = "popup." .. reminders.name,
      width = popup_width,
      align = "left",
      icon = {
        string = icons.circle,
      },
      label = { string = reminder['formated'], color = color },
      click_script = 'open -a Reminders'
    })
    counter = counter + 1
  end
end

local function get_reminders()
  sbar.exec("$CONFIG_DIR/plugins/Reminders/.build/debug/Reminders", function(reminders_list)
    local all = reminders_list["all"]
    local overdue = reminders_list["overdue"]
    local today = reminders_list["today"]
    local upcoming = reminders_list["upcoming"]
    local first = reminders_list["all"][1]
    local count_str = tostring(#all)

    local label = first["formated"]
    count:set({ label = "(" .. count_str .. ")" })
    reminders:set({ label = label })

    add_reminder_list(overdue, "Overdue", colors.red)

    add_reminder_list(today, "Today", colors.white)

    add_reminder_list(upcoming, "Upcoming", colors.white)

  end)
end


get_reminders()

local function list_collapse_details()
  local drawing = reminders:query().popup.drawing == "on"
  if not drawing then return end
  reminders:set({ popup = { drawing = false } })
end

local function toggle_reminders_list()
  local should_draw = reminders:query().popup.drawing == "off"
  if should_draw then
    reminders:set({ popup = { drawing = true } })
  else
    list_collapse_details()
  end
end

reminders:subscribe("mouse.clicked", toggle_reminders_list)
reminders:subscribe("mouse.exited.global", list_collapse_details)

-- TODO: Find a better way to update the list:
reminders:subscribe("front_app_switched", function(env)
  clear_reminder_lists()
  get_reminders()
end)
