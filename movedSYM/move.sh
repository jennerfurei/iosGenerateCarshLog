# Type a script or drag a script file from your workspace to insert its path.
# 获取项目名称
PROJECT_NAME=${TARGET_NAME}

# 获取构建配置
CONFIGURATION=${CONFIGURATION}

# 获取构建目录
BUILD_DIR=${BUILT_PRODUCTS_DIR}

# 获取当前构建的dSYM文件目录
DSYM_DIR="${BUILD_DIR}/${PROJECT_NAME}.app.dSYM"

# 检查dSYM文件是否存在
if [ -d "$DSYM_DIR" ]; then
  # 目标路径
  DEST_DIR="$HOME/Desktop/${PROJECT_NAME}.app.dSYM"
  
  # 复制dSYM文件到桌面
  cp -R "$DSYM_DIR" "$DEST_DIR"
  
  echo "dSYM文件已成功复制到桌面: $DEST_DIR"
else
  echo "未找到dSYM文件"
fi