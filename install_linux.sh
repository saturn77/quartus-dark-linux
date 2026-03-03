#!/bin/bash
# Install dark mode editor/RTL colors into Quartus settings on Linux.
# Run once per machine. Quartus must be closed.

QREG="$HOME/.altera.quartus/quartus2.qreg"

if [ ! -f "$QREG" ]; then
    echo "Error: $QREG not found. Run Quartus at least once first."
    exit 1
fi

# Check if already patched
if grep -q "AFCQ_TED_BACKGROUND_COLOR" "$QREG"; then
    echo "Editor colors already configured in $QREG"
    exit 0
fi

cp "$QREG" "$QREG.bak"
echo "Backup saved to $QREG.bak"

# Find the section header to append after
SECTION=$(grep -n '^\[.*_quartus\]' "$QREG" | tail -1 | cut -d: -f1)
if [ -z "$SECTION" ]; then
    echo "Error: Cannot find quartus settings section in $QREG"
    exit 1
fi

# Insert dark editor colors after the section's existing Color_version line,
# or append to end of section if not found
COLORS='Altera_Foundation_Class\\AFCQ_TED_KEYWORD_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\0\\0)
Altera_Foundation_Class\\AFCQ_TED_NORMAL_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\xdf\\xdf\\xe1\\xe1\\xe2\\xe2\\0\\0)
Altera_Foundation_Class\\AFCQ_TED_BACKGROUND_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\x19\\x19##--\\0\\0)
Altera_Foundation_Class\\AFCQ_TED_LINE_NUMBER_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\xdf\\xdf\\xe1\\xe1\\xe2\\xe2\\0\\0)
Altera_Foundation_Class\\AFCQ_TED_LINE_BACKGROUND_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\x19\\x19##--\\0\\0)
Altera_Foundation_Class\\AFCQ_TED_SELECTION_FG_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\xdf\\xdf\\xe1\\xe1\\xe2\\xe2\\0\\0)
Altera_Foundation_Class\\AFCQ_TED_VHDL_KEYWORDS_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\x7f\\x7f\\xaa\\xaa\\xff\\xff\\0\\0)
Altera_Foundation_Class\\AFCQ_TED_VERILOG_KEYWORDS_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\x7f\\x7f\\xaa\\xaa\\xff\\xff\\0\\0)
Altera_Foundation_Class\\AFCQ_TED_TCL_KEYWORDS_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\x7f\\x7f\\xaa\\xaa\\xff\\xff\\0\\0)
Altera_Foundation_Class\\AFCQ_TED_SYS_VERILOG_KEYWORDS_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\x7f\\x7f\\xaa\\xaa\\xff\\xff\\0\\0)
Altera_Foundation_Class\\AFCQ_TED_MULTI_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\0\\0\\xc0\\xc0\\0\\0\\0\\0)
Altera_Foundation_Class\\AFCQ_TED_SINGLE_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\0\\0\\xc0\\xc0\\0\\0\\0\\0)
Altera_Foundation_Class\\AFCQ_TED_STRING_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\xe8\\xe8\\0\\0\\xe8\\xe8\\0\\0)
Altera_Foundation_Class\\AFCQ_TED_IDENTIFIER_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\xe8\\xe8\\0\\0\\xe8\\xe8\\0\\0)
Altera_Foundation_Class\\AFCQ_MSW_WARNING_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\x7f\\x7f\\xaa\\xaa\\xff\\xff\\0\\0)
Altera_Foundation_Class\\AFCQ_MSW_CRITICAL_WARNING_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\x7f\\x7f\\xaa\\xaa\\xff\\xff\\0\\0)
Altera_Foundation_Class\\AFCQ_MSW_INFO_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\0\\0\\xc0\\xc0\\0\\0\\0\\0)
Altera_Foundation_Class\\AFCQ_NUI_BACKGROUND_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\x19\\x19##--\\0\\0)
Altera_Foundation_Class\\AFCQ_NUI_INSTANE_FONT_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\xff\\xff\\0\\0\\xff\\xff\\0\\0)
Altera_Foundation_Class\\AFCQ_NUI_RIPPER_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\0\\0\\xff\\xff\\xff\\xff\\0\\0)
Altera_Foundation_Class\\AFCQ_NUI_NET_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\xff\\xff\\xff\\xff\\0\\0\\0\\0)
Altera_Foundation_Class\\AFCQ_NUI_PIN_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\0\\0\\xff\\xff\\xff\\xff\\0\\0)
Altera_Foundation_Class\\AFCQ_NUI_PORT_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\0\\0\\xff\\xff\\xff\\xff\\0\\0)
Altera_Foundation_Class\\AFCQ_NUI_PRIMITIVE_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\x1a\\x1arr\\xbb\\xbb\\0\\0)
Altera_Foundation_Class\\AFCQ_NUI_SELECTION_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\xff\\xff\\0\\0\\0\\0\\0\\0)
Altera_Foundation_Class\\AFCQ_NUI_INSTANCE_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\0\\0\\x80\\x80\\0\\0\\0\\0)
Altera_Foundation_Class\\AFCQ_NUI_INSTANCE_REGION_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\x37\\x37\\x41\\x41OO\\0\\0)
Altera_Foundation_Class\\AFCQ_NUI_INSTANCE_ATOM_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\x1a\\x1arr\\xbb\\xbb\\0\\0)
Altera_Foundation_Class\\AFCQ_NUI_ENCRYPTED_INSTANCE_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xff\\x45\\x45SSdd\\0\\0)
Altera_Foundation_Class\\AFCQ_PPLQ_BACKGROUND_COLOR=@Variant(\\0\\0\\0\\x43\\x1\\xff\\xffTThhzz\\0\\0)'

# Append colors before the Color_version line
sed -i "/Color_version=/i\\
$COLORS" "$QREG"

echo "Dark editor, RTL viewer, and pin planner colors installed."
echo "Restart Quartus to see changes."
