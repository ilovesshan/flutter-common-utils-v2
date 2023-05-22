import 'package:common_utils_v2/common_utils_v2.dart';


typedef  OnDeletePressed = Function(int index);

class ImagePreviewPage extends StatefulWidget {
  static const String routeName = '/imagePreview';
  String path;
  bool isNetworkPath;

  ImagePreviewPage(this.path, {this.isNetworkPath = false});

  @override
  _ImagePreviewPageState createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: widget.isNetworkPath
              ? PhotoView(
            imageProvider: NetworkImage(widget.path),
            loadingBuilder: (context, event) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    SizedBox(height: 15),
                    Text("加载中....", style: TextStyle(color: Colors.white, fontSize: 14))
                  ],
                ),
              );
            },
          )
              : PhotoView(imageProvider: FileImage(File(widget.path)),
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}




class MultipleImagePreviewPage extends StatefulWidget {
  static const String routeName = '/multipleImagePreview';

  late final List<String> fileList;
  late  int initialPage;
  late  bool canDelete;
  late  OnDeletePressed onDeletePressed;

  MultipleImagePreviewPage(this.fileList, {this.initialPage = 0, required this.canDelete, required this.onDeletePressed});

  @override
  _MultipleImagePreviewPageState createState() => _MultipleImagePreviewPageState();
}

class _MultipleImagePreviewPageState extends State<MultipleImagePreviewPage> {

  late PageController _pageController ;

  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageController =  PageController(initialPage: widget.initialPage-1);
    _currentIndex = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenUtil().screenWidth, height: ScreenUtil().screenHeight, color: Colors.black,
        child: widget.fileList.isEmpty
          ? GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(child: Center(child: Text("没有预览的图片", style: TextStyle(fontSize: 18.sp, color: const Color(0xFFFFFFFF))))),
              onTap: () {
              Navigator.of(context).pop();
            })
          : Column(
            children: [
              /// 占位符
              Container(height: 150, color: Colors.black, alignment: Alignment.center, child: Text("$_currentIndex/${widget.fileList.length}", style: TextStyle(fontSize: 24.sp, color: Colors.white))),

              /// 图片预览区域
              Expanded(
                child: GestureDetector(
                  child: Container(
                      color: Colors.black,
                      child: PhotoViewGallery.builder(
                        customSize:Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                        scrollPhysics: const BouncingScrollPhysics(),
                        builder: (BuildContext context, int index) {
                          return (widget.fileList[index].contains("http://") || widget.fileList[index].contains("https://")) ? PhotoViewGalleryPageOptions(
                            basePosition: Alignment.center,
                            imageProvider: NetworkImage(widget.fileList[index],),
                            initialScale: PhotoViewComputedScale.contained * 0.8,
                            heroAttributes: PhotoViewHeroAttributes(tag: const Uuid().v1().toString()),
                          ) : PhotoViewGalleryPageOptions(
                            imageProvider: FileImage(File(widget.fileList[index])),
                            initialScale: PhotoViewComputedScale.contained * 0.8,
                            heroAttributes: PhotoViewHeroAttributes(tag: const Uuid().v1().toString()),
                          );
                        },
                        itemCount: widget.fileList.length,
                        loadingBuilder: (context, event) => SizedBox(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox( width: 30.w, height: 30.w,child: const CircularProgressIndicator(strokeWidth: 1,)),
                              SizedBox(height: 20.h),
                              Text("正在加载中...", style: TextStyle(fontSize: 12.sp, color: const Color(0xFFFFFFFF))),
                            ],
                          ),
                        ),
                        backgroundDecoration: const BoxDecoration(),
                        pageController: _pageController,
                        onPageChanged: (index){
                          _currentIndex = index + 1;
                          setState(() {});
                        },
                      )
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),

              /// 当前滑动数量 删除按钮
              Container(
                height: 200, color: Colors.black, alignment: Alignment.center,
                child:!widget.canDelete ? const SizedBox():  GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(height: 50, width: 100.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.delete, size: 24.sp, color: Colors.white),
                        SizedBox(width: 8.w),
                        Text("删除", style: TextStyle(fontSize: 16.sp, color: Colors.white))
                      ]
                    )
                  ),
                  onTap: (){
                    if(_currentIndex == widget.fileList.length){
                      _currentIndex--;
                      widget.onDeletePressed(_currentIndex);
                    }else{
                      widget.onDeletePressed(_currentIndex-1);
                    }
                    setState(() {});
                    if(widget.fileList.isEmpty){
                      Navigator.of(context).pop();
                    }
                  },
                )
              )
            ]
          ),
      ),
    );
  }
}

