#!/bin/bash

# Start
echo "N_m3u8DL-RE下载调用 by RoadIsLong 2024.07.02"

cd "$(dirname "$0")"

# Directory settings
REfile="N_m3u8DL-RE"
TempDir="/Users/long/dev/foo/m3u8DL/temps"
SaveDir="/Users/long/dev/foo/m3u8DL/videos"
ffmpeg="ffmpeg"

# Menu
menu() {
    clear
    echo ""
    echo "下载选项"
    echo "**********************************************************"
    echo ""
    echo "1、m3u8视频单个下载"
    echo ""
    echo "2、m3u8视频批量下载"
    echo ""
    echo "3、直播录制"
    echo ""
    echo "**********************************************************"
    echo ""
    echo "*当前设置主程序名:$REfile"
    echo "*当前设置输出目录:$SaveDir"
    echo "*当前设置临时目录:$TempDir"
    echo "*当前设置FFMPEG路径:$ffmpeg"
    echo ""
    echo "**********************************************************"
    echo ""
    read -p "请输入操作序号并回车（1、2、3）：" a
    clear
    if [ "$a" = "1" ]; then
        m3u8_download
    elif [ "$a" = "2" ]; then
        m3u8_batch_download
    elif [ "$a" = "3" ]; then
        live_record
    fi
}

setting_path() {
    input="input.txt"
    output="output.sh"
}

setting_m3u8_params() {
    AntiADs="--ad-keyword \"\d{1,}o\d{3,4}.ts|\/ad\w{0,}\/\""
    m3u8_params="--download-retry-count:9 --auto-select:true --check-segments-count:false --no-log:true $AntiADs --append-url-params:true  -mt:true --mp4-real-time-decryption:true --ui-language:zh-CN"
}

setting_live_record_params() {
    live_record_params="--no-log:true -mt:true --mp4-real-time-decryption:true --ui-language:zh-CN -sv best -sa best --live-pipe-mux:true --live-keep-segments:false --live-fix-vtt-by-audio:true $live_record_limit -M format=mp4:bin_path=\"$ffmpeg\""
}

m3u8_download() {
    common_input
    setting_path
    setting_m3u8_params
    m3u8_download_print
    m3u8_downloading
    when_done
}

m3u8_batch_download() {
    setting_path
    batch_input
    setting_m3u8_params
    batch_excute
    when_done
}

live_record() {
    common_input
    live_record_input
    setting_path
    setting_live_record_params
    live_record_print
    live_recording
    when_done
}

common_input() {
    read -p "请输入链接: " link
    if [ -z "$link" ]; then
        echo "错误：输入不能为空！"
        common_input
    fi
    read -p "请输入保存文件名: " filename
    if [ -z "$filename" ]; then
        echo "错误：输入不能为空！"
        common_input
    fi
}

batch_input() {
    read -p "请输入包含批量下载链接的文件名或完整路径(**.txt,留空确认则默认设置当前文件夹的input.txt): " batchfile_input
    if [ -n "$batchfile_input" ]; then
        input="$batchfile_input"
    fi
    read -p "请输入将输出批量下载sh的文件名(**,不带后缀名sh. 留空确认则默认设置当前文件夹的output.sh): " batchfile_output
    if [ -n "$batchfile_output" ]; then
        output="$batchfile_output.sh"
    fi
}

batch_excute() {
    params="--tmp-dir \"$TempDir\" --save-dir \"$SaveDir\" --ffmpeg-binary-path \"$ffmpeg\" $m3u8_params"
    count=$(wc -l < "$input")
    cur_line=0
	> "$output"
    while IFS="$" read -r filename link; do
        ((cur_line++))
        outstring="$REfile \"$link\" --save-name \"$filename\" $params"
        echo "$outstring" >> "$output"
    done < "$input"
    clear
    chmod +x "$output"
    ./"$output"
}

live_record_input() {
    read -p "请输入录制时长限制(格式：HH:mm:ss, 可为空): " record_limit
    if [ -z "$record_limit" ]; then
        live_record_limit=""
    else
        live_record_limit="--live-record-limit $record_limit"
    fi
}

m3u8_download_print() {
    echo "下载命令:$REfile \"$link\" $m3u8_params --ffmpeg-binary-path $ffmpeg --tmp-dir $TempDir --save-dir $SaveDir --save-name \"$filename\""
}

live_record_print() {
    echo "下载命令:$REfile \"$link\" $live_record_params --tmp-dir $TempDir --save-dir $SaveDir --save-name \"$filename\""
}

m3u8_downloading() {
    $REfile "$link" $m3u8_params --ffmpeg-binary-path $ffmpeg --tmp-dir $TempDir --save-dir $SaveDir --save-name "$filename"
}

live_recording() {
    $REfile "$link" $live_record_params --tmp-dir $TempDir --save-dir $SaveDir --save-name "$filename"
}

when_done() {
	echo ""
	echo ""
	echo ""
	echo "**********************************************************"
	echo ""
	echo "  程序结束.5s后自动关闭"
	echo ""
	echo "**********************************************************"
	echo ""
	echo ""
	echo ""
    sleep 5
    exit
}

menu