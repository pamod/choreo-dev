package org.wso2.demo.loyalty;

import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


@CrossOrigin(maxAge = 3600)
@RestController
@RequestMapping("/loyalty")
public class LoyaltyPointController {
    Map<String, LoyaltyPoint> loyaltyPointRepository = new ConcurrentHashMap<>();

    @PostMapping()
    public String addPoints(@RequestBody LoyaltyPoint point) {
        String successMessage = "{ status: \"success\"}";
        LoyaltyPoint loyaltyPoints = loyaltyPointRepository.get(point.getName());
        if (null == loyaltyPoints) {
            loyaltyPointRepository.put(point.getName(), point);
        } else {
            loyaltyPoints.setTotalNumberOfPoints(loyaltyPoints.getTotalNumberOfPoints() +
                    point.getTotalNumberOfPoints());
            loyaltyPointRepository.put(point.getName(), loyaltyPoints);
        }
        return successMessage;
    }

    @GetMapping()
    public LoyaltyPoint getPoints(@RequestParam String name) {
        return loyaltyPointRepository.get(name);
    }

    @DeleteMapping()
    public String deletePoints(@RequestParam String name) {
        String successMessage = "{ status: \"success\"}";
        loyaltyPointRepository.remove(name);
        return successMessage;
    }

    @GetMapping("/all")
    public Map<String, LoyaltyPoint> getAllPoints() {
        return loyaltyPointRepository;
    }
}
