package cr.cdrb.commons.file;

import java.awt.image.BufferedImage;
import java.io.OutputStream;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServlet;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSON;
import cr.cdrb.commons.tools.DateUtil;
import cr.cdrb.web.edu.domains.eduplans.EduReviews;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import oracle.net.aso.s;

/*
 * 
 *
 */
public class ImageUtil {

    /*
 *   ///生成公章图片
 *review  审核单位信息
     */
    public static void createSaveImage(EduReviews review, HttpServletRequest request, HttpServletResponse response) throws Throwable {
        response.setContentType("image/png");
        OutputStream output = response.getOutputStream();
        Seal s = new Seal();
        s.firm = review.getCurrent_unit().contains("成都铁路局") ? review.getCurrent_unit() : "成都铁路局" + review.getCurrent_unit();
        s.time = DateUtil.FormatDate(review.getReview_date(),"yyyy/MM/dd",java.util.Locale.CHINA);
        BufferedImage image = s.export2pic(null);
        ImageIO.write(image, "png", response.getOutputStream());
//			if (image != null) {
//				encoder.encode(image);
//			}
        output.flush();
        output.close();
    }
}
